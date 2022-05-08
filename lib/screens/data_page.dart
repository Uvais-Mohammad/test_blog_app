import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_demo/blocs/drink/drink_bloc.dart';
import 'package:new_demo/blocs/user/user_bloc.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);
  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(child: Text('Drinks')),
                Tab(child: Text('Users')),
              ],
            ),
          ),
          actions: <Widget>[
            BlocBuilder<DrinkBloc, DrinkState>(
              builder: (context, state) {
                if (state is DrinkLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(data: state.drinkResponse.drinks!),
                      );
                    },
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(data: []),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            DrinkData(),
            UserData(),
          ],
        ),
      ),
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<UserBloc>(context).add(FetchUserEvent());
            },
            child: ListView.separated(
              key: const PageStorageKey<String>('My Trips'),
              itemCount: state.userResponse.results!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title:
                        Text(state.userResponse.results![index].name!.title!),
                    subtitle: Text(
                        state.userResponse.results![index].location!.country!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        state.userResponse.results![index].picture!.large!,
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 0);
              },
            ),
          );
        }
        if (state is UserError) {
          return const Center(
            child: Text('Error'),
          );
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}

class DrinkData extends StatelessWidget {
  const DrinkData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinkBloc, DrinkState>(
      builder: (context, state) {
        if (state is DrinkLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DrinkLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<DrinkBloc>(context).add(FetchDrinkEvent());
            },
            child: ListView.separated(
              key: const PageStorageKey<String>('My Trips'),
              itemCount: state.drinkResponse.drinks!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(state.drinkResponse.drinks![index].strDrink!),
                    subtitle:
                        Text(state.drinkResponse.drinks![index].strCategory!),
                    leading: Image.network(
                      state.drinkResponse.drinks![index].strDrinkThumb!,
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 0);
              },
            ),
          );
        }
        if (state is DrinkError) {
          return const Center(
            child: Text('Error'),
          );
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}

void showSearchWindow(List<dynamic> data) {}

class CustomSearchDelegate extends SearchDelegate {
  final List<dynamic> data;

  CustomSearchDelegate({required this.data});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

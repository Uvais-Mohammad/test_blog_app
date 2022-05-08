import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_demo/blocs/home/home_bloc.dart';
import 'package:new_demo/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      welcome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        print(state.status);
        if (state.status == HomeStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == HomeStatus.medicineLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == HomeStatus.medicineLoaded) {
          List<String> medicines = [];
          for (final medicine
              in state.medicineResponse!.problems[0].diabetes[0].medications) {
            for (final classes in medicine.medicationsClasses) {
              for (final clas in classes.className) {
                for (final ass_drug in clas.associatedDrug) {
                  medicines.add(ass_drug.name);
                }
                for (final ass_drug in clas.associatedDrug2) {
                  medicines.add(ass_drug.name);
                }
              }
            }
          }

          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(medicines[index]),
              );
            },
          );
        }
        return Container(
          child: Center(
            child: Text('HomeScreen'),
          ),
        );
      }),floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, dataPageRoute);
        },
        child: const Icon(Icons.forward),
      ),
    );
  }

  void welcome() async {
    var hour = DateTime.now().hour;
    late String message;
    if (hour < 12) {
      message = 'Morning';
    }
    if (hour < 17) {
      message = 'Afternoon';
    }
    message = 'Evening';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Welcome'),
              content: Text("Good $message"),
            )).then((value) => context.read<HomeBloc>().add(FetchMedicine()));
  }
}

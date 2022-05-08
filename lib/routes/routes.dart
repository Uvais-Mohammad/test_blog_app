import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_demo/blocs/drink/drink_bloc.dart';
import 'package:new_demo/blocs/home/home_bloc.dart';
import 'package:new_demo/blocs/user/user_bloc.dart';
import 'package:new_demo/screens/data_page.dart';
import 'package:new_demo/screens/home_page.dart';
import 'package:new_demo/screens/login_page.dart';

const String initalRoute = '/';
const String signUpRoute = '/signup';
const String homeRoute = '/home';
const String dataPageRoute = '/dataPage';

final HomeBloc homeBloc = HomeBloc();
final DrinkBloc drinkBloc = DrinkBloc();
final UserBloc userBloc = UserBloc();

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case initalRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case homeRoute:
        return MaterialPageRoute(builder: (_) {
          return  BlocProvider.value(
            value: homeBloc..add(FetchMedicine()),
            child: const HomePage(),
          );
        });
        case dataPageRoute:
        return MaterialPageRoute(builder: (_) {
          return  MultiBlocProvider(
            providers: [
              BlocProvider.value(value:drinkBloc..add(FetchDrinkEvent()) ),
              BlocProvider.value(value: userBloc..add(FetchUserEvent())),
            ],
            child: const DataPage(),
          );
        });
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("Error"),
                  ),
                ));
    }
  }
}

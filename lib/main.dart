
import 'package:flutter/material.dart';

import 'package:new_demo/routes/routes.dart' as rt;
import 'package:new_demo/services/preference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: rt.initalRoute,
      onGenerateRoute: rt.Router.onGenerateRoute,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/loginPage.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homepage.dart';

void main() async {
  runApp(MyApp());
  // await Hive.init();
  await Hive.initFlutter();
  await Hive.openBox('users');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/loginPage.dart';
import 'package:flutter_application_1/screen/todo_list.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('users');
  runApp(MyApp());
  // await Hive.init();
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
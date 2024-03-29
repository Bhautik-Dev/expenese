import 'package:expenese/expense.dart';
import 'package:expenese/home.dart';
import 'package:expenese/login/checkBox.dart';
import 'package:expenese/login/messages/home.dart';
import 'package:expenese/login/messages/login.dart';
import 'package:expenese/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/binding_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingController(),
      theme: ThemeData(fontFamily: "RobotoCondensed"),
      home:Home(),
    );
  }
}

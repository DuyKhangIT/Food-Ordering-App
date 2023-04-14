import 'package:flutter/material.dart';
import 'package:th_flutter/routes/routes.dart';
import 'package:th_flutter/screen/sign_in/sign_in_page.dart';
import 'package:th_flutter/screen/splash_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

Fluttertoast? flutterToast;
void main() {
  flutterToast = Fluttertoast();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home:  const SplashPage(),
    );
  }
}


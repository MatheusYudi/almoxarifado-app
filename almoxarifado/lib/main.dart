import 'package:almoxarifado/theme/app_themes.dart';
import 'package:almoxarifado/util/routes.dart';
import 'package:almoxarifado/view/login.dart';
import 'package:flutter/material.dart';

// TODO finalizar relações entre classes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almoxarifado',
      theme: AppTheme.defaultTheme,
      home: const LoginView(),
      routes: Routes.getRoutes(),
    );
  }
}
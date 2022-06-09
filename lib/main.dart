import 'package:almoxarifado/theme/app_themes.dart';
import 'package:almoxarifado/util/routes.dart';
import 'package:almoxarifado/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'controller/funcionario_atual_controller.dart';

// TODO finalizar relações entre classes

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FuncionarioAtualController>(
          create: (_) => FuncionarioAtualController(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Almoxarifado',
      theme: AppTheme.defaultTheme,//ThemeData(primarySwatch: Colors.blue),//ThemeData.dark(),
      home: const LoginView(),
      routes: Routes.getRoutes(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
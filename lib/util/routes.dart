import 'package:flutter/cupertino.dart';

import '../view/home_page.dart';
import '../view/login.dart';
import '../view/fornecedores.dart';

class Routes{
  static const String homePage = '/home_page';
  static const String login = '/login';
  static const String fornecedores = '/fornecedores';

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (context) => const LoginView(),
      homePage : (context) => const HomePageView(),
      fornecedores: (context)=> const Fornecedores(),
    };
  }

}
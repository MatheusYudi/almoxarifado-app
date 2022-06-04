import 'package:almoxarifado/widgets/default_app_bar.dart';
import 'package:almoxarifado/widgets/default_dropdown.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
import '../widgets/drawer_menu_itens.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({ Key? key }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Home'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.builder(
                itemCount: MenuItensList.itens.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  if(MenuItensList.itens[index].children.isEmpty)
                  {
                    return ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, MenuItensList.itens[index].pageRoute),
                      child: MenuItensList.itens[index].text
                    );
                  }
                  else
                  {
                    return const SizedBox.shrink();
                  }
                }
              ),
            ],
          ),
        ),
      ),
      drawer: const DefaultUserDrawer(),
    );
  }
}
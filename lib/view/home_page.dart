import 'package:almoxarifado/widgets/default_app_bar.dart';
import 'package:almoxarifado/widgets/default_dropdown.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          padding: const EdgeInsets.all(80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      DateFormat.yMMMd('pt_BR').format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm').format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 100),
              Container(width: 1, color: Colors.white),
              const SizedBox(width: 100),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      itemCount: MenuItensList.itens.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if(index > 0 && MenuItensList.itens[index].children.isEmpty)
                        {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, MenuItensList.itens[index].pageRoute),
                              child: MenuItensList.itens[index].text,
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                              ),
                            ),
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
            ],
          ),
        ),
      ),
      drawer: const DefaultUserDrawer(),
    );
  }
}
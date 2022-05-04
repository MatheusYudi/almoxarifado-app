import 'package:flutter/material.dart';

import 'menu_itens.dart';

class Menu extends StatelessWidget {
  Widget menuItemToTile(List<MenuItem> arrayMenu, context)
  {
    List drawerItens = arrayMenu.map((item) {
      if(item.children.isEmpty)
      {
        return ListTile(
                  title: item.text,
                  leading: item.icon,
                  onTap: () => Navigator.of(context).pushReplacementNamed(item.pageRoute),
                );
      }
      else
      {
        return ExpansionTile(
            leading: item.icon,
            title: item.text ?? const SizedBox.shrink(),
            textColor: Colors.black87,   
            backgroundColor: Colors.white.withOpacity(0.1),         
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: menuItemToTile(item.children, context),
              )
            ],
          );
      }
    }).toList();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: drawerItens.length,
      itemBuilder: (BuildContext context, index)
      {
        return drawerItens[index];
      }
    );
  }

  final List<MenuItem> pages;
  final Widget? footer;

  final Map _user = {
    'profilePicture':'https://picsum.photos/200',
    'name':'Nome da Silva Sobrenome', 
    'email':'email@email.com'};

  Menu({
    required this.pages,
    this.footer,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image.network(_user['profilePicture']),
            ),
            accountName: Text(_user['name']),
            accountEmail: Text(_user['email']),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: menuItemToTile(pages, context),
            ),
          ),
          footer ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'menu_itens.dart';

class Menu extends StatelessWidget {
  Widget arrayToWidget(List<MenuItem> arrayMenu, context)
  {
    List drawerItens = arrayMenu.map((item) {
      if(item.children.isEmpty)
      {
        return ListTile(
                  title: item.text,
                  leading: Icon(item.icon),
                  onTap: () => Navigator.of(context).pushReplacementNamed(item.pageRoute),
                );
      }
      else
      {
        return ExpansionTile(
            title: item.text ?? const SizedBox.shrink(),
            backgroundColor: Colors.blue[400],
            textColor: Colors.black87,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: arrayToWidget(item.children, context),
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

  final Map _user = {
    'profilePicture':'https://picsum.photos/200',
    'name':'Nome da Silva Sobrenome', 
    'email':'email@email.com'};

  Menu({required this.pages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1E88E5),
              ),
              currentAccountPicture: ClipOval(
                child: Image.network(_user['profilePicture']),
              ),
              accountName: Text(_user['name']),
              accountEmail: Text(_user['email']),
            ),
            Expanded(child: arrayToWidget(pages, context)),
          ],
        ),
      ),
    );
  }
}
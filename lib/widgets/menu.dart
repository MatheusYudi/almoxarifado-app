import 'package:flutter/material.dart';
import 'drawer_menu_itens.dart';

class Menu extends StatelessWidget {
  Widget menuItemToTile(List<DraweMenuItem> arrayMenu, context)
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
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
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

  final List<DraweMenuItem> pages;
  final Widget? footer;

  final Map user;

  const Menu({
    required this.pages,
    this.user = const {},
    this.footer,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      user['email'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // UserAccountsDrawerHeader(
          //   currentAccountPicture: ClipOval(
          //     child: Image.network(user['profilePicture']),
          //   ),
          //   accountName: Text(user['name']),
          //   accountEmail: Text(user['email']),
          // ),
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
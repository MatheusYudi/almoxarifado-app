import 'package:flutter/material.dart';

class DefaultDrawer extends StatelessWidget {

  Widget arrayToWidget(List arrayMenu, context)
  {
    arrayMenu = arrayMenu.map((item) {
      if(item['children'] == null)
      {
        return ListTile(
                  title: Text(item['text']),
                  leading: Icon(item['icon']),
                  onTap: () => Navigator.of(context).pushReplacementNamed(item['pageName']),
                );
      }
      else
      {
        return ExpansionTile(
            title: Text(item['text']),
            textColor: Colors.black87,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: arrayToWidget(item['children'], context),
              )
            ],
          );
      }
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: arrayMenu.length,
      itemBuilder: (BuildContext context, index)
      {
        return arrayMenu[index];
      }
    );
  }

  final List pages;

  final Map _user = {
    'profilePicture':'https://picsum.photos/200',
    'name':'Nome da Silva Sobrenome', 
    'email':'email@email.com'
  };

  final Widget? footer;

  DefaultDrawer({this.footer, required this.pages, Key? key}) : super(key: key);

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
          Expanded(child: arrayToWidget(pages, context)),
          footer ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
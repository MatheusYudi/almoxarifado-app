import 'package:flutter/material.dart';

import '../util/routes.dart';
import 'menu.dart';
import 'menu_itens.dart';

class DefaultUserDrawer extends StatelessWidget {
  const DefaultUserDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Menu(
      pages: MenuItensList.itens,
      footer: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 70)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.logout, color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Logout', 
                //style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onPressed: () => Navigator.pushReplacementNamed(context, Routes.login),
      ),
    );
  }
}
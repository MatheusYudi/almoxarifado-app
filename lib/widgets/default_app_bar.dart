import 'package:flutter/material.dart';
import 'package:almoxarifado/util/routes.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  
  final String pageName;
  final List<Widget> actions;

  const DefaultAppBar({
    this.pageName = '',
    this.actions = const [],
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          IconButton(
            onPressed: () { Navigator.pushNamed(context, Routes.homePage); },
            icon: const Icon(Icons.lightbulb_outline)
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 24, 0),
            child: Container(            
              height: 40,
              width: 1,            
              color: Colors.white,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(pageName),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
import 'package:flutter/material.dart';

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
      leading: const Icon(Icons.lightbulb_outline),
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(            
              height: 40,
              width: 2,            
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
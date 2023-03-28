import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../wrappers/expanding_menu.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({Key? key, required this.updateMenu}) : super(key: key);
final updateMenu;
  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 112.0,
      children: [
         ActionButton(
                onPressed: () {
                 widget.updateMenu(0);
                },
                icon: const Icon(Icons.person),
              ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(1);
          },
          icon: const Icon(Icons.comment),
        ),
      ActionButton(
          onPressed: () {
            widget.updateMenu(2);
          },
          icon: const Icon(Icons.thumb_up),
        ),
      ActionButton(
          onPressed: () {
            widget.updateMenu(3);
          },
          icon: const Icon(Icons.favorite),
        ),
      ActionButton(
          onPressed: () {
            widget.updateMenu(4);
          },
          icon: const Icon(Icons.photo_album),
        ),
      ],
    );
  }
}

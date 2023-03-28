import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../sanity/image_url_builder.dart';
import '../../wrappers/expanding_menu.dart';

class SettingsPageMenu extends StatefulWidget {
  const SettingsPageMenu({Key? key, required this.updateMenu})
      : super(key: key);
  final updateMenu;

  @override
  State<SettingsPageMenu> createState() => _SettingsPageMenuState();
}

class _SettingsPageMenuState extends State<SettingsPageMenu> {
  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 158.0,
      children: [

        ActionButton(
          onPressed: () {
            widget.updateMenu(0);
          },
          icon: const Icon(Icons.edit),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(2);
          },
          icon: const Icon(Icons.block),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(1);
          },
          icon: const Icon(Icons.timeline),
        ),
        ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/profilesPage');
          },
          icon: const Icon(Icons.people),
        ),
      ],
    );
  }
}

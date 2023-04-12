import 'package:flutter/material.dart';

import '../../wrappers/expanding_fab.dart';
enum SettingsMenuOptions {
  EDIT_PROFILE,
  BLOCKS,
  TIMELINE,
  PEOPLE,
}
class SettingsPageMenu extends StatefulWidget {
  const SettingsPageMenu({Key? key, required this.updateMenu})
      : super(key: key);
  final Function updateMenu;

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
            tooltip: "Logout",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/logout');
            },
            icon: const Icon(Icons.logout),
          ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(SettingsMenuOptions.EDIT_PROFILE.index);
          },
          icon: const Icon(Icons.edit),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(SettingsMenuOptions.BLOCKS.index);
          },
          icon: const Icon(Icons.block),
        ),
        ActionButton(
          onPressed: () {
            widget.updateMenu(SettingsMenuOptions.TIMELINE.index);
          },
          icon: const Icon(Icons.timeline),
        ),
        ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
          icon: const Icon(Icons.home),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../wrappers/expanding_menu.dart';

class LoginMenu extends StatefulWidget {
  const LoginMenu({Key? key}) : super(key: key);

  @override
  State<LoginMenu> createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 62.0,
      children: [
        ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/register');
          },
          icon: const Icon(Icons.app_registration),
        ),
        if(AuthInherited.of(context)?.authController?.myAppUser != null)
          ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/profilesPage');
          },
          icon: const Icon(Icons.people),
        ),

        AuthInherited.of(context)?.authController?.isLoggedIn == true
            ? ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/logout');
          },
          icon: const Icon(Icons.logout),
        )
            : ActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
          },
          icon: const Icon(Icons.login),
        ),
      ],
    );
  }
}

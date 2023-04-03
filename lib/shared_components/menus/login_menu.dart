import 'package:cookout/models/app_user.dart';
import 'package:flutter/material.dart';

import '../../config/default_config.dart';
import '../../models/controllers/auth_inherited.dart';
import '../../wrappers/expanding_fab.dart';

class LoginMenu extends StatefulWidget {
  const LoginMenu({Key? key   
  }) : super(key: key);

  

  @override
  State<LoginMenu> createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  late AppUser? myAppUser = null;

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    myAppUser = AuthInherited.of(context)?.authController?.myAppUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
     
      distance: 62.0,
      children: [
        if (myAppUser != null)
          ActionButton(
            tooltip: "Logout",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/logout');
            },
            icon: const Icon(Icons.logout),
          ),
        if (myAppUser != null)
          ActionButton(
            tooltip: "Profiles",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/profilesPage');
            },
            icon: const Icon(Icons.people),
          ),
        if (myAppUser != null)
          ActionButton(
            tooltip: "Posts",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/postsPage');
            },
            icon: const Icon(Icons.post_add),
          ),
        if (myAppUser == null)
          ActionButton(
            tooltip: "Login",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        if (myAppUser != null)
          ActionButton(
            tooltip: "Home",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.home),
          ),
        if (myAppUser == null)
          ActionButton(
            tooltip: "Register",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/register');
            },
            icon: const Icon(Icons.app_registration),
          ),
      ],
    );
  }
}

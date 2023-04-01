import 'package:cookout/shared_components/user_block_mini.dart';
import 'package:flutter/material.dart';

import '../models/controllers/auth_inherited.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // key: Key((AuthInherited.of(context)
      //             ?.authController
      //             ?.myAppUser?.userId
      //             .toString() ??
      //         "") +
      //     (AuthInherited.of(context)?.authController?.loggedInUser?.uid.toString() ??
      //         "")),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.values[0],
              ),
              child: Text('Chat Menu',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      color: Colors.white)),
            ),
          ),
          ListTile(
            title: AuthInherited.of(context)?.authController?.myAppUser != null
                ? UserBlockMini(
                    user: AuthInherited.of(context)?.authController?.myAppUser)
                : Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/login');
                        },
                        child: const Icon(Icons.login),
                      ),
                      const Text("Login"),
                    ],
                  ),
          ),
          ListTile(
            title: const Text("Profiles"),
            onTap: () {
              Navigator.popAndPushNamed(context, '/profilesPage');
            },
          ),
          ListTile(
            title: const Text("Register User"),
            onTap: () {
              Navigator.popAndPushNamed(context, '/register');
            },
          ),
        ],
      ),
    );
  }
}

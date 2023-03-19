import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/shared_components/user_block_mini.dart';
import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: Key(authController.myAppUser.toString() + authController.loggedInUser.toString()),
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
          authController.myAppUser != null ? UserBlockMini(user: authController.myAppUser): Text("no logged in user"),
           ListTile(title: Text("Profiles"),onTap: (){
            Navigator.popAndPushNamed(context, '/loggedInHome');
          },),
          ListTile(title: const Text("Login"),
            onTap: (){
            Navigator.popAndPushNamed(context, '/login');
          },
          ),
           ListTile(title: Text("Logout"),
            onTap: (){
              Navigator.popAndPushNamed(context, '/logout');
            },),
           ListTile(title: Text("Register User"),onTap: (){
             Navigator.popAndPushNamed(context, '/register');
           },),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100,child: InkWell(onTap:(){
      GoRouter.of(context).go('/home');

      // Navigator.pushNamed(context, '/home',);
    },child:Image.asset('assets/logo-w.png')),);
  }
}

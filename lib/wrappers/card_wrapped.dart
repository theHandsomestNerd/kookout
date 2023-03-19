import 'package:flutter/material.dart';

class CardWrapped extends StatelessWidget {
  const CardWrapped({super.key, required this.child, this.height});

  final double? height;
  final child;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 300.0,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CardWrapped extends StatelessWidget {
  const CardWrapped({super.key, required this.child, this.height});

  final double? height;
  final Widget child;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 400.0,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
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

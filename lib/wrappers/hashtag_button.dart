import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HashtagButton extends StatelessWidget {
  const HashtagButton({
    Key? key,
    required this.hashtag,
  }) : super(
          key: key,
        );
  final String hashtag;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.black87,
      onPressed: () {
        GoRouter.of(context).go("/hashtag/$hashtag");
      },
      child: Text(
        "#$hashtag",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

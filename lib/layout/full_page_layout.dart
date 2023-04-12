import 'package:flutter/material.dart';

class FullPageLayout extends StatefulWidget {
  const FullPageLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<FullPageLayout> createState() => _FullPageLayoutState();
}

class _FullPageLayoutState extends State<FullPageLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}

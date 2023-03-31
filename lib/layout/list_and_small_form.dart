import 'package:flutter/material.dart';

class ListAndSmallFormLayout extends StatefulWidget {
  const ListAndSmallFormLayout({
    super.key,
    required this.listChild,
    required this.formChild,
    this.height,
  });

  final Widget listChild;
  final height;
  final Widget formChild;

  @override
  State<ListAndSmallFormLayout> createState() => _ListAndSmallFormLayoutState();
}

class _ListAndSmallFormLayoutState extends State<ListAndSmallFormLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(child: widget.listChild),
          SizedBox(
              height: widget.height ?? 150,
              child: widget.formChild),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ListAndSmallFormLayout extends StatefulWidget {
  const ListAndSmallFormLayout({
    super.key,
    required this.listChild,
    required this.formChild,
  });

  final Widget listChild;
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
          SizedBox(height: 120, child: widget.formChild),
        ],
      ),
    );
  }
}

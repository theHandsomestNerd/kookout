import 'dart:developer';

import 'package:flutter/material.dart';
class ToolButton extends StatefulWidget {
  const ToolButton(
      {super.key,
        required this.action,
        required this.iconData,
        required this.color,
        required this.label,
        this.isLoading,
        this.text,
        this.isActive});

  final String label;
  final String? text;
  final action;
  final IconData iconData;
  final MaterialColor color;
  final bool? isActive;
  final bool? isLoading;

  @override
  State<ToolButton> createState() => _ToolButtonState();
}

class _ToolButtonState extends State<ToolButton> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // return Flexible(
    //   child: MaterialButton(
    //     color: widget.isActive == true ? Colors.white : widget.color,
    //     textColor: widget.isActive == true ? widget.color : Colors.white,
    //     onPressed: () {
    //       // _toggleActive();
    //       widget.action(context);
    //     },
    //     child: Padding(
    //       padding: const EdgeInsets.fromLTRB(25, 16, 25, 16),
    //       child: (widget.isLoading == false || widget.isLoading == null) ?Icon(
    //         widget.iconData,
    //         size: 48.0,
    //         semanticLabel: widget.label,
    //       ):CircularProgressIndicator(
    //         color: widget.isActive == true ? widget.color : Colors.white,
    //       ),
    //     ),
    //   ),
    // );

    return Row(
      children: [
        Text(
          widget.text ?? "",
          style: TextStyle(
            color: widget.isActive == true ? widget.color : Colors.black,
          ),
        ),
        widget.isLoading != true ?IconButton(
          onPressed: () {
            widget.action(context);
          },
          isSelected: widget.isActive,
          icon: Icon(
            widget.iconData,
            color: widget.isActive == true ? widget.color : Colors.black,
            size: 24.0,
            semanticLabel: widget.label,
          ),
        ):Padding(
          padding: const EdgeInsets.fromLTRB(12,8,8,8),
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
                color: widget.isActive == true ? widget.color : Colors.grey,
              ),
          ),
        ),
      ],
    );
  }
}

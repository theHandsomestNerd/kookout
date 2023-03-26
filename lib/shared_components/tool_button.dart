
import 'package:flutter/material.dart';

class ToolButton extends StatefulWidget {
  const ToolButton(
      {super.key,
      required this.action,
      required this.iconData,
      required this.color,
      required this.label,
      this.isHideLabel,
      this.isLoading,
      this.isDisabled,
      this.text,
      this.isActive});

  final String label;
  final bool? isHideLabel;
  final bool? isDisabled;
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
  Widget build(BuildContext context) {
    return TextButton(
        key: Key(widget.text ?? ""),
        onPressed: widget.isDisabled != true
            ? () {
                widget.action(context);
              }
            : null,
        child: Row(
          children: [
            widget.isLoading != true
                ? Icon(
                    widget.iconData,
                    color:
                        widget.isActive == true ? widget.color : Colors.black,
                    size: 30.0,
                    semanticLabel: widget.label,
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: widget.isActive == true
                            ? widget.color
                            : Colors.grey,
                      ),
                    ),
                  ),
            const SizedBox(
              width: 16,
            ),
            widget.isHideLabel != true
                ? Text(
                    key: Key(widget.text ?? "0"),
                    widget.text ?? "0",
                    style: TextStyle(
                      fontSize: ((widget.text?.length ?? 0) > 4) ? 16 : 30,
                      color:
                          widget.isActive == true ? widget.color : Colors.black,
                    ),
                  )
                : const Text(""),
          ],
        ));
  }
}

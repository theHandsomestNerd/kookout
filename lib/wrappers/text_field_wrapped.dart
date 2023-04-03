import 'package:flutter/material.dart';

class TextFieldWrapped extends StatefulWidget {
  const TextFieldWrapped({
    Key? key,
    this.initialValue,
    this.autofocus,
    this.setField,
    this.validator,
    this.labelText,
    this.autocorrect,
    this.autoCorrect,
    this.obscureText,
    this.enableSuggestions,
    this.icon,
  }) : super(key: key);

  final String? initialValue;
  final String? labelText;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final bool? autofocus;
  final bool? autoCorrect;
  final setField;
  final IconData? icon;
  final validator;

  @override
  State<TextFieldWrapped> createState() => _TextFieldWrappedState();
}

class _TextFieldWrappedState extends State<TextFieldWrapped> {
  String? errorText = "";
  String? text = "";

  _setField(theText) {
    setState(() {
      text = theText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      obscureText: widget.obscureText ?? false,
      enableSuggestions: widget.enableSuggestions ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      autocorrect: widget.autocorrect ?? false,
      initialValue: widget.initialValue,
      onChanged: (e) {
        _setField(e);
        widget.setField(e);
      },
      decoration: InputDecoration(
        helperText: errorText,
        filled: true,
        fillColor: Colors.white70,
        prefixIcon: widget.icon!=null? Icon(widget.icon):null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        labelText: widget.labelText,
      ),
    );
  }
}

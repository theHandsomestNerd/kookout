import 'package:flutter/material.dart';

import '../models/submodels/height.dart';

class HeightInput extends StatefulWidget {
  const HeightInput({super.key, required this.updateHeight, this.initialValue});

  final updateHeight;
  final Height? initialValue;

  @override
  State<HeightInput> createState() => _HeightInputState();
}

class _HeightInputState extends State<HeightInput> {
  int? _inches;
  int? _feet;

  @override
  void initState() {
    super.initState();

    _inches = widget.initialValue?.inches;
    _feet = widget.initialValue?.feet;
  }

  void _setInches(int newInches) {
    setState(() {
      _inches = newInches;
    });

    widget.updateHeight(_feet ?? 0, _inches);
  }

  void _setFeet(int newFeet) {
    setState(() {
      _feet = newFeet;
    });
    widget.updateHeight(_feet, _inches ?? 0);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            key: ObjectKey(
                "${widget.initialValue?.feet.toString() ?? ""}-height-feet"),
            initialValue: widget.initialValue?.feet.toString() ?? "",
            onChanged: (e) {
              if (e != "null") {
                _setFeet(int.parse(e));
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Height Feet',
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
            key: ObjectKey(
                "${widget.initialValue?.inches.toString() ?? ""}-height-inches"),
            initialValue: widget.initialValue?.inches.toString() ?? "",
            onChanged: (e) {
              if (e != "null") {
                _setInches(int.parse(e));
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Height Inches',
            ),
          ),
        ),
      ],
    );
  }
}

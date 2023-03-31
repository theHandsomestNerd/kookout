import 'package:chat_line/wrappers/card_with_background.dart';
import 'package:flutter/material.dart';

class CardWithActions extends StatelessWidget {
  final String? action1Text;

  final action1OnPressed;
  final ImageProvider image;

  final String? action2Text;

  final action2OnPressed;

  const CardWithActions({
    super.key,
    this.action1Text,
    this.action1OnPressed,
    this.action2Text,
    this.action2OnPressed,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: super.key,
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 24.0,
      ),
      child: CardWithBackground(
        image: image,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (action1Text != null)
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(action1Text!),
                        ),
                        onPressed: action1OnPressed,
                      ),
                    if (action2Text != null) const SizedBox(width: 8),
                    if (action2Text != null)
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(action2Text!),
                              Icon(
                                Icons.chevron_right,
                              ),
                            ],
                          ),
                        ),
                        onPressed: action2OnPressed,
                      ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

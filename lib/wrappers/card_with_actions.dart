import 'package:chat_line/wrappers/card_with_background.dart';
import 'package:flutter/material.dart';

class CardWithActions extends StatelessWidget {
  final String? action1Text;
  final String? caption;

  final action1OnPressed;
  final ImageProvider image;

  final String? action2Text;

  final action2OnPressed;

  const CardWithActions(
      {super.key,
      this.caption,
      this.action1Text,
      this.action1OnPressed,
      this.action2Text,
      this.action2OnPressed,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: super.key,
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 24.0,
      ),
      child: ListTile(
        title: CardWithBackground(
          image: image,
          child: Column(
            mainAxisAlignment: caption == null ? MainAxisAlignment.end:MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (caption != null)
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 96.0),
                  child: Card(
                    color: Colors.white.withOpacity(.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        caption!,
                      ),
                    ),
                  ),
                ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  if (action1Text != null)
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0)),
                        ),
                        color: Colors.black.withOpacity(.5),
                        onPressed: action1OnPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            action1Text!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  // if (action2Text != null) const SizedBox(width: 8),
                  const SizedBox(width: 1),
                  if (action2Text != null)
                    Expanded(
                      child: Container(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0)),
                          ),
                          color: Colors.black.withOpacity(.5),
                          onPressed: action2OnPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              action2Text!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

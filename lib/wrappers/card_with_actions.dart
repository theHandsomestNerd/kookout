import 'package:chat_line/wrappers/card_with_background.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardWithActions extends StatelessWidget {
  final String? action1Text;
  final String? caption;
  final locationRow;

  final action1OnPressed;
  final ImageProvider image;

  final String? action2Text;

  final action2OnPressed;
  final infoCard;
  final DateTime? when;

  const CardWithActions(
      {super.key,
      this.when,
      this.caption,
      this.action1Text,
      this.action1OnPressed,
      this.action2Text,
      this.action2OnPressed,
      this.locationRow,
      this.infoCard,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: super.key,
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        // horizontal: 24.0,
      ),
      child: ListTile(
        title: Stack(
          children: [
            CardWithBackground(
              image: image,
              child: Column(
                mainAxisAlignment: caption != null
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (locationRow != null)
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: locationRow!),
                  if (infoCard != null)
                    Row(
                      children: [
                        Column(
                          children: [infoCard!],
                        )
                      ],
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.merge(
                                      TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.merge(
                                        TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
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
            if (caption != null)
              Column(
                children: [
                  Container(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            color: Colors.white.withOpacity(.8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if (when != null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(timeago.format(when!)),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        caption!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

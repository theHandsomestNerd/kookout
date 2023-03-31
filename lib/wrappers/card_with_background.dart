import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWithBackground extends StatelessWidget {
  const CardWithBackground({
    Key? key,
    required this.child,
    this.width,
    required this.image,
    this.height,
    this.shape,
  }) : super(key: key);

  final Widget child;
  final shape;
  final double? width;
  final double? height;
  final ImageProvider image;

  // "https://placeimg.com/640/480/any"
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: shape != null
          ? shape
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              //set border radius more than 50% of height and width to make circle
            ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                image: image != null
                    ? DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                    : null,
              ),
              child: Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(flex: 1, child: child)]),
            ),
          ),
        ],
      ),
    );
  }
}

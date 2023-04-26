import 'package:flutter/material.dart';

import '../platform_dependent/image_uploader_abstract.dart';

class AppImageUploader extends StatefulWidget {
  final Function uploadImage;
  final String? text;

  final ImageProvider? image;
  final ImageUploader imageUploader;
  final bool? hideInfo;

  final double? width;
  final double? height;

  const AppImageUploader({
    super.key,
    required this.uploadImage,
    required this.imageUploader,
    this.image,
    this.width,
    this.height,
    this.hideInfo,
    this.text,
  });

  @override
  State<AppImageUploader> createState() => _AppImageUploaderState();
}

class _AppImageUploaderState extends State<AppImageUploader> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: widget.imageUploader.body(
            context,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
            widget.image
          ),
        ),
      ],
    );
  }
}

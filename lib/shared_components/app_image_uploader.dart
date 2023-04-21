import 'package:cookowt/models/controllers/auth_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import '../models/controllers/auth_controller.dart';
import '../models/controllers/post_controller.dart';
import '../platform_dependent/image_uploader_abstract.dart';

class AppImageUploader extends StatefulWidget {
  final Function uploadImage;
  final String? text;

  // final ImageProvider? image;
  final ImageUploader imageUploader;
  final bool? hideInfo;

  final double? width;
  final double? height;

  const AppImageUploader({
    super.key,
    required this.uploadImage,
    required this.imageUploader,
    // this.image,
    this.width,
    this.height,
    this.hideInfo,
    this.text,
  });

  @override
  State<AppImageUploader> createState() => _AppImageUploaderState();
}

class _AppImageUploaderState extends State<AppImageUploader> {
  AuthController? authController;
  PostController? postController;

  // ImageProvider? imageToBeUploaded;
  late SanityImage? profileImage;

  // Uint8List? theFileBytes;

  // CroppedFile? croppedFile;
  // Listener? imageUploaderListener;

  @override
  initState() {
    super.initState();


    // imageToBeUploaded = _getMyProfileImage(null);
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    setState(() {});
  }

  // _getMyProfileImage(PlatformFile? theFile) {
  //   if (theFile != null) {
  //     if (kDebugMode) {
  //       print("profile image is froom memory");
  //     }
  //     return MemoryImage(
  //       theFile.bytes ?? [] as Uint8List,
  //     );
  //   }
  //   if (kDebugMode) {
  //     print("profile image is default");
  //   }
  //   return widget.image ?? const AssetImage('assets/blankProfileImage.png');
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: widget.imageUploader.body(
            context,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
      ],
    );
  }
}

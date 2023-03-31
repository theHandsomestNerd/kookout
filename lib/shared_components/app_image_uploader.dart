import 'package:chat_line/models/controllers/auth_inherited.dart';
import 'package:chat_line/wrappers/card_with_background.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import '../models/controllers/auth_controller.dart';
import '../models/controllers/post_controller.dart';
import '../platform_dependent/image_uploader_abstract.dart';

class AppImageUploader extends StatefulWidget {
  final uploadImage;
  final String? text;
  final ImageProvider? image;
  final ImageUploader imageUploader;

  const AppImageUploader(
      {super.key,
      required this.uploadImage,
      required this.imageUploader,
      this.image,
      this.text});

  @override
  State<AppImageUploader> createState() => _AppImageUploaderState();
}

class _AppImageUploaderState extends State<AppImageUploader> {
  AuthController? authController;
  final PostController postController = PostController.init();

  var imageToBeUploaded = null;
  late SanityImage? profileImage = null;

  @override
  initState() {
    super.initState();
    imageToBeUploaded = _getMyProfileImage(null);
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    setState(() {});
  }

  _getMyProfileImage(PlatformFile? theFile) {
    if (theFile != null) {
      if (kDebugMode) {
        print("profile image is froom memory");
      }
      return MemoryImage(
        theFile.bytes ?? [] as Uint8List,
      );
    }
    if (kDebugMode) {
      print("profile image is default");
    }
    return widget.image ?? const AssetImage('assets/blankProfileImage.png');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Column(
      children: [
        Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageToBeUploaded != null
                    ? Column(
                        key: ObjectKey(imageToBeUploaded),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 350.0,
                              width: 350.0,
                            child: CardWithBackground(
                              height: 350,
                              width: 350,
                              image:
                                  _getMyProfileImage(widget.imageUploader.file),
                              child: OutlinedButton(
                                onPressed: () async {
                                  await widget.imageUploader.uploadImage().then(
                                    (theImage) async {
                                      setState(
                                        () {
                                          // print("the image from uploadImage befoe comprssion $theImage");
                                          imageToBeUploaded =
                                              _getMyProfileImage(theImage);
                                        },
                                      );
                                      widget.uploadImage(widget.imageUploader);
                                    },
                                  );
                                },
                                child: Text(widget.text ?? "Change Photo"),
                              ),
                            ),
                          ),
                          Text(widget.imageUploader.file?.name ?? ""),
                          const SizedBox(
                            width: 16,
                          ),
                          widget.imageUploader.file?.size != null
                              ? Text(
                                  "${widget.imageUploader.file?.size.toString() ?? ''} bytes")
                              : const Text(""),
                        ],
                      )
                    : Column(
                        children: const [],
                      ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

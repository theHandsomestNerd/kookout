import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'image_uploader_abstract.dart';

class ImageUploaderImpl extends ImageUploader {

  ImageUploaderImpl() {
    file = null;
    fileExtension = null;
    contentType = null;
    theCompressedCompleter = null;
    compressedPlatformFuture = null;
  }

  @override
  Future<PlatformFile?> uploadImage() async {
    final XFile? pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 1000,
        preferredCameraDevice: CameraDevice.rear);

    PlatformFile? theFile;
    if (pickedImageFile != null) {
      theFile = PlatformFile(
          bytes: await pickedImageFile.readAsBytes(),
          name: pickedImageFile.name,
          size: await pickedImageFile.length());

      file = theFile;
      if (kDebugMode) {
        print(
          "File Picked ${theFile.name} extension:${theFile.extension} ${theFile.size} bytes");
      }
      return theFile;
    } else {
      // User canceled the picker
    }
    return null;
  }
}

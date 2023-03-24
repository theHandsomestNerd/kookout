import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_support/file_support.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'image_uploader_abstract.dart';

class ImageUploaderImpl extends ImageUploader {
  @override
  late PlatformFile? file = null;
  @override
  late String? fileExtension = "";
  @override
  late String? contentType = "";
  @override
  late Future<PlatformFile> compressedPlatformFuture;

  ImageUploader() {
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
      print(
          "File Picked ${theFile.name} extension:${theFile?.extension} ${theFile?.size} bytes");
      return theFile;
    } else {
      // User canceled the picker
    }
    return null;
  }

}

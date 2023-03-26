import 'dart:async';

import 'package:file_picker/file_picker.dart';

import 'image_uploader_abstract.dart';

class ImageUploaderImpl extends ImageUploader {
  @override
  Future<PlatformFile?> uploadImage() async {
    throw Exception("Stub implementation");
  }

}

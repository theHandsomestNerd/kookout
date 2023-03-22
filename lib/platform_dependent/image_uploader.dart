import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

import 'image_uploader_abstract.dart';

class ImageUploaderImpl extends ImageUploader {
  @override
  late PlatformFile? file;
  @override
  late String? fileExtension;
  @override
  late String? contentType;
  @override
  late Completer? theCompressedCompleter;
  @override
  late Future<PlatformFile> compressedPlatformFuture;
  @override
  late bool? isCompressing;

  @override
  late Future<ImageFile> futureCompressedFile;
  @override
  late ImageFile? compressedFile;

  @override
  Future<PlatformFile?> uploadImage() async {
    throw Exception("Stub implementation");
  }

}

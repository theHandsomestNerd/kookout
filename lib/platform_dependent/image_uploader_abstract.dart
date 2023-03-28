import 'dart:async';

import 'package:file_picker/file_picker.dart';

abstract class ImageUploader {
  late PlatformFile? file = null;
  late String? fileExtension;
  late String? contentType;
  late Completer? theCompressedCompleter;
  late Future<PlatformFile>? compressedPlatformFuture;

  Future<PlatformFile?> uploadImage();

  }
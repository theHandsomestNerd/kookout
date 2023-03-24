import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

abstract class ImageUploader {
  late PlatformFile? file;
  late String? fileExtension;
  late String? contentType;
  late Completer? theCompressedCompleter;
  late Future<PlatformFile> compressedPlatformFuture;

  Future<PlatformFile?> uploadImage();

  }
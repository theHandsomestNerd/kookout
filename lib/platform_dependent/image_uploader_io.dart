import 'package:file_picker/file_picker.dart';

import 'image_uploader_abstract.dart';


class ImageUploaderImpl extends ImageUploader {
  @override
  Future<PlatformFile?> uploadImage( ) async {
    // var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // file = pickedFile;
    // return pickedFile;
    return null;
  }

  Future<PlatformFile?> compressImageUploader() async {
  throw Exception("Stub implementation");
  }
}
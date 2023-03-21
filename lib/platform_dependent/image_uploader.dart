import 'image_uploader_abstract.dart';


class ImageUploaderImpl extends ImageUploader {
  @override
  late String filename="";
  @override
  late var fileData = null;
  @override
  Future<dynamic> uploadImage() async {
    throw Exception("Stub implementation");
  }
}

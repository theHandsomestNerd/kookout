import 'package:image_picker/image_picker.dart';

import 'image_uploader_abstract.dart';


class ImageUploaderImpl extends ImageUploader {
  @override
  late String filename="";
  @override
  late var fileData = null;
  @override
  Future<dynamic> uploadImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    filename = file?.path ?? "";
    return;
  }

  void _updateProfilePhoto() async {

  }
}
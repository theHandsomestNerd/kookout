import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:image_compression_flutter/image_compression_flutter.dart';

import 'image_uploader_abstract.dart';

class ImageUploaderImpl extends ImageUploader {
  @override
  Future<dynamic> uploadImage() async {

    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    var completer = new Completer();

    uploadInput.onChange.listen((e) {
      print("The file input changed ${uploadInput.files?.length}");
      final files = uploadInput.files;
      if (files?.length == 1) {
        final File file = files![0];
        final reader = FileReader();
        reader.onLoadEnd.listen((e) async {
          completer.complete(
              {"filename": uploadInput.value ?? "", "fileData": reader.result});
          // filename = uploadInput.value ?? "";
          // fileData = reader.result;
          print("loaded: ${file.name} from ${uploadInput.value} ");
          print("type: ${reader.result.runtimeType}");
          return;
        });
        reader.onError.listen((e) {
          completer.completeError(e);
          print(e);
          return;
        });
        reader.onProgress.listen((ProgressEvent event) {
          print("${event.loaded}/${event.total}");
        });
        reader.readAsArrayBuffer(file);
      }
    });

    Map<String, dynamic> completedFileResponse = await completer.future;

    print("afterr future complert ${completedFileResponse['filename']}");

    filename = completedFileResponse['filename'];

    fileData = completedFileResponse['fileData'];

    return {"filename": filename, "fileData": completedFileResponse['fileData']};
  }
}

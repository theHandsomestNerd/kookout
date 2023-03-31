import 'package:chat_line/layout/full_page_layout.dart';
import 'package:chat_line/models/controllers/auth_inherited.dart';
import 'package:chat_line/shared_components/menus/posts_page_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import '../../platform_dependent/image_uploader.dart'
    if (dart.library.io) '../../platform_dependent/image_uploader_io.dart'
    if (dart.library.html) '../../platform_dependent/image_uploader_html.dart';
import '../models/controllers/auth_controller.dart';
import '../models/controllers/post_controller.dart';
import '../platform_dependent/image_uploader_abstract.dart';
import '../shared_components/app_image_uploader.dart';
import '../wrappers/loading_button.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late ImageUploader? imageUploader;
  AuthController? authController;
  final PostController postController = PostController.init();

  String? _postBody;
  bool? _isPosting;
  var imageToBeUploaded = null;
  late SanityImage? profileImage = null;

  @override
  initState() {
    super.initState();
    imageUploader = ImageUploaderImpl();
    imageToBeUploaded = _getMyProfileImage(null);
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    setState(() {});
  }

  void _setPostBody(String newPostBody) {
    setState(() {
      _postBody = newPostBody;
    });
  }

  _makePost(context) async {
    String? postResponse;

    postResponse = await postController.createPost(_postBody ?? "",
        imageUploader?.file?.name ?? "", imageUploader?.file?.bytes, context);

    return postResponse;
  }

  _getMyProfileImage(PlatformFile? theFile) {
    if (theFile != null) {
      if (kDebugMode) {
        print("profile image is froom memory");
      }
      return MemoryImage(
        theFile.bytes ?? [] as Uint8List,
      );
    }
    if (kDebugMode) {
      print("profile image is default");
    }
    return const AssetImage('assets/blankProfileImage.png');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      floatingActionButton: PostsPageMenu(
        updateMenu: () {},
      ),
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Chat Line - Create Post"),
      ),
      body: FullPageLayout(
        child: Column(
          children: [
            AppImageUploader(
              text: "Change Main Post Photo",
              imageUploader: imageUploader!,
              uploadImage: (uploader){
                imageUploader = uploader;
              },
            ),
            TextFormField(
              autofocus: true,
              onChanged: (e) {
                _setPostBody(e);
              },
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Post:',
              ),
            ),
            LoadingButton(
              action: () {
                _makePost(context);
              },
              isLoading: _isPosting,
              text: "Post",
            )
          ],
        ),
      ),
    );
  }
}

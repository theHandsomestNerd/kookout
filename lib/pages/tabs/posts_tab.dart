import 'package:chat_line/layout/list_and_small_form.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/posts/post_thread.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import '../../models/controllers/auth_controller.dart';
import '../../models/controllers/auth_inherited.dart';
import '../../models/controllers/post_controller.dart';
import '../../platform_dependent/image_uploader_abstract.dart';
import '../../wrappers/loading_button.dart';
import '../../platform_dependent/image_uploader.dart'
    if (dart.library.io) '../../platform_dependent/image_uploader_io.dart'
    if (dart.library.html) '../../platform_dependent/image_uploader_html.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({
    super.key,
  });

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  List<Post> _postsList = [];
  ImageUploader? imageUploader;
  AuthController? authController;
  PostController? postController;

  @override
  initState() {
    super.initState();
    imageUploader = ImageUploaderImpl();
    // _getPosts().then((listOfPosts) {
    //   _postsList = listOfPosts;
    // });
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    postController = AuthInherited.of(context)?.postController;
    _postsList = await _getPosts();
    setState(() {});
    if (kDebugMode) {
      print("dependencies changed profile list");
    }
  }

  Future<List<Post>> _getPosts() async {
    var thePosts = await postController?.getPosts();

    return thePosts ?? <Post>[];
  }

  String? _postBody;
  bool? _isPosting;

  void _setPostBody(String newPostBody) {
    setState(() {
      _postBody = newPostBody;
    });
  }

  _makePost(context) async {
    String? postResponse;

    postResponse = await postController?.createPost(_postBody ?? "",
        imageUploader?.file?.name ?? "", imageUploader?.file?.bytes, context);

    return postResponse;
  }

  Widget? imageToBeUploaded;
  late SanityImage? profileImage = null;

  _getMyProfileImage(PlatformFile? theFile) {
    if (theFile != null) {
      if (kDebugMode) {
        print("profile image is froom memory");
      }
      return Image.memory(
        theFile.bytes ?? [] as Uint8List,
        height: 350,
        width: 350,
      );
    }
    if (kDebugMode) {
      print("profile image is default");
    }
    return Image.asset(height: 350, width: 350, 'assets/blankProfileImage.png');
  }

  @override
  Widget build(BuildContext context) {
    return ListAndSmallFormLayout(
      height: 550,
      listChild: PostThread(
        key: ObjectKey(_postsList),
        posts: _postsList,
      ),
      formChild: Column(
        children: [
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
          Column(
            // key:ObjectKey(profileImage),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageToBeUploaded != null
                      ? Column(
                          key: ObjectKey(imageToBeUploaded),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imageToBeUploaded!,
                            Text(imageUploader?.file?.name ?? ""),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                                "${imageUploader?.file?.size.toString() ?? ''} bytes"),
                          ],
                        )
                      : const Text("no image"),
                ],
              ),
              OutlinedButton(
                onPressed: () async {
                  await imageUploader?.uploadImage().then((theImage) async {
                    setState(() {
                      // print("the image from uploadImage befoe comprssion $theImage");
                      imageToBeUploaded = _getMyProfileImage(theImage);
                    });
                    setState(() {});
                  });
                },
                child: const Text("Change Profile Photo"),
              ),
            ],
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
    );
  }
}

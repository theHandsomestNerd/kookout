import 'package:cookowt/layout/full_page_layout.dart';
import 'package:cookowt/models/controllers/auth_inherited.dart';
import 'package:cookowt/shared_components/menus/posts_page_menu.dart';
import 'package:cookowt/wrappers/alerts_snackbar.dart';
import 'package:cookowt/wrappers/analytics_loading_button.dart';
import 'package:cookowt/wrappers/app_scaffold_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:go_router/go_router.dart';

import '../../platform_dependent/image_uploader.dart'
    if (dart.library.io) '../../platform_dependent/image_uploader_io.dart'
    if (dart.library.html) '../../platform_dependent/image_uploader_html.dart';
import '../models/controllers/analytics_controller.dart';
import '../models/controllers/auth_controller.dart';
import '../models/controllers/post_controller.dart';
import '../platform_dependent/image_uploader_abstract.dart';
import '../shared_components/app_image_uploader.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    super.key,
  });

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final AlertSnackbar _alertSnackbar = AlertSnackbar();
  ImageUploader? imageUploader;
  AuthController? authController;
  PostController? postController;
  AnalyticsController? analyticsController;

  String? _postBody;
  bool? _isPosting;
  ImageProvider? imageToBeUploaded;
  late SanityImage? profileImage;

  Uint8List? theFileBytes;
  @override
  initState() {
    super.initState();

    var theUploader = ImageUploaderImpl();
    imageUploader = theUploader;
    theUploader.addListener(() async {
      print("image uploader change");
      if(theUploader.croppedFile != null){
        print("there iz a cropped");
        theFileBytes = await theUploader.croppedFile?.readAsBytes();
      } else {
        print("there iz a file");
        theFileBytes = await theUploader.file?.readAsBytes();
      }
      setState(() {

      });
    });
    // imageToBeUploaded = _getMyProfileImage(null);
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AuthController? theAuthController =
        AuthInherited.of(context)?.authController;
    authController = theAuthController;
    PostController? thePostController =
        AuthInherited.of(context)?.postController;
    postController = thePostController;

    AnalyticsController? theAnalyticsController =
        AuthInherited.of(context)?.analyticsController;

    theAnalyticsController?.logScreenView('Create Post');

    analyticsController = theAnalyticsController;

    if (!((_postBody?.length ?? -1) <= 0) && (_postBody?.length ?? 0) < 5) {
      await analyticsController
          ?.sendAnalyticsEvent('post-form-enabled', {"body": _postBody});
    }
    setState(() {});
  }

  void _setPostBody(String newPostBody) async {
    setState(() {
      _postBody = newPostBody;
    });
  }

  _makePost(context) async {
    setState(() {
      _isPosting = true;
    });
    String? postResponse;

    // print(" make post");
    postResponse = await postController?.createPost(_postBody ?? "",
        imageUploader?.file?.name ?? "", theFileBytes, context);

    setState(() {
      _isPosting = false;
    });

    // print(" post response $postResponse");
    return postResponse ?? "FAIL";
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    sendSuccess() async {
      await _alertSnackbar.showSuccessAlert("Post created:", context);
    }

    sendError() async {
      await _alertSnackbar.showErrorAlert(
          "Post creation failed. Try again.", context);
    }

    return AppScaffoldWrapper(
      floatingActionMenu: PostsPageMenu(
        updateMenu: () {},
      ),
      child: FullPageLayout(
        child: Column(
          children: [
            AppImageUploader(
              height: 350,
              width: 350,
              text: "Change Main Post Photo",
              imageUploader: imageUploader!,
              uploadImage: (uploader) {
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
            AnalyticsLoadingButton(
              analyticsEventName: 'create-post',
              analyticsEventData: {"body": _postBody, "author": ""},
              isDisabled: ((_postBody?.length ?? -1) <= 0) || _isPosting == true,
              action: (innerContext) async {
                var status = await _makePost(innerContext);

                if (status == "SUCCESS") {
                  await sendSuccess();
                } else if (status == "FAIL") {
                  await sendError();
                }
                GoRouter.of(context).go('/postsPage');

                // Navigator.popAndPushNamed(context, '/postsPage');
              },
              text: "Post",
            )
          ],
        ),
      ),
    );
  }
}

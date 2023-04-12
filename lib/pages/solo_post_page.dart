import 'package:cookout/layout/full_page_layout.dart';
import 'package:cookout/layout/list_and_small_form.dart';
import 'package:cookout/models/clients/api_client.dart';
import 'package:cookout/models/controllers/auth_inherited.dart';
import 'package:cookout/sanity/sanity_image_builder.dart';
import 'package:cookout/shared_components/comments/paged_comment_thread.dart';
import 'package:cookout/shared_components/tool_button.dart';
import 'package:cookout/wrappers/analytics_loading_button.dart';
import 'package:cookout/wrappers/app_scaffold_wrapper.dart';
import 'package:cookout/wrappers/author_and_text.dart';
import 'package:cookout/wrappers/card_with_background.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/comment.dart';
import '../models/controllers/analytics_controller.dart';
import '../models/controllers/post_controller.dart';
import '../models/post.dart';

class SoloPostPage extends StatefulWidget {
  const SoloPostPage({Key? key, this.thisPostId}) : super(key: key);

  final String? thisPostId;

  @override
  State<SoloPostPage> createState() => _SoloPostPageState();
}

class _SoloPostPageState extends State<SoloPostPage> {
  bool _isCommenting = false;
  String? commentBody = "";
  ApiClient? profileClient;
  String? thisPostId;
  final PagingController<String, Comment> _pagingController =
      PagingController(firstPageKey: "");

  AnalyticsController? analyticsController;
  late Post? thePost = null;
  late PostController? postController = null;
  String status = "";

  _commentThisProfile() async {
    _isCommenting = true;
    if (profileClient != null && thisPostId != null && commentBody != null) {
      var thestatus = await profileClient!
          .commentProfile(thisPostId!, commentBody!, 'post-comment');
      status = thestatus;
    }

    commentBody = "";
    _isCommenting = false;
    setState(() {});
  }

  _setCommentBody(e) {
    commentBody = e;
    setState(() {});
  }

  @override
  initState() {
    // thePost= postController?.getPost(thisPostId);
    thisPostId = widget.thisPostId;
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    AnalyticsController? theAnalyticsController =
        AuthInherited.of(context)?.analyticsController;
    PostController? thePostController =
        AuthInherited.of(context)?.postController;
    if (thePostController != null && thePost == null) {
      postController = thePostController;
      var aPost = await thePostController.getPost(thisPostId ?? "");
      if (aPost != null) {
        thePost = aPost;
        // print("A post retrieved $aPost");
      }
    }

    theAnalyticsController?.logScreenView('Post');
    if (theAnalyticsController != null && analyticsController == null) {
      analyticsController = theAnalyticsController;
    }

    ApiClient? theClient =
        AuthInherited.of(context)?.chatController?.profileClient;

    if (theClient != null && profileClient == null) {
      profileClient = theClient;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWrapper(
      child: FullPageLayout(
        child: SlidingUpPanel(
          backdropEnabled: true,
          isDraggable: true,
          parallaxEnabled: true,
          maxHeight: 900,
          color: Colors.transparent,
          minHeight: 100,
          body: Stack(children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 4,
                  child: CardWithBackground(
                    image: SanityImageBuilder.imageProviderFor(
                            sanityImage: thePost?.mainImage)
                        .image,
                    child: Container(),
                  ),
                ),
              ],
            ),
            if (thePost?.author != null)
              Column(
                children: [
                  AuthorAndText(
                    author: thePost!.author!,
                    when: thePost!.publishedAt!,
                    body: thePost!.body!,
                  ),
                ],
              )
          ]),
          panel: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 2,
                          width: 50,
                          child: Container(color: Colors.red),
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 48),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ToolButton(
                                      action: () {},
                                      iconData: Icons.thumb_up,
                                      color: Colors.blue,
                                      label: "0"),
                                  ToolButton(
                                      action: () {},
                                      iconData: Icons.comment,
                                      color: Colors.blue,
                                      label: "0"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (thePost?.author != null)
                        Column(
                          children: [
                            AuthorAndText(
                              author: thePost!.author!,
                              when: thePost!.publishedAt!,
                              body: thePost!.body!,
                            ),
                          ],
                        ),
                      SizedBox(height: 3,child: Container(color: Colors.red),),
                      Expanded(
                          child: Container(
                        child: Flex(
                          mainAxisSize: MainAxisSize.max,
                          direction: Axis.vertical,
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: thePost?.id != null
                                  ? PagedCommentThread(
                                      key: Key(thisPostId ?? ""),
                                      pagingController: _pagingController,
                                      postId: thePost!.id!,
                                    )
                                  : Container(),
                            ),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 150),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        autofocus: true,
                                        onChanged: (e) {
                                          _setCommentBody(e);
                                        },
                                        initialValue: commentBody,
                                        minLines: 2,
                                        maxLines: 4,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Comment:',
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      AnalyticsLoadingButton(
                                        isDisabled: _isCommenting,
                                        analyticsEventName:
                                            'solo-post-create-comment',
                                        analyticsEventData: {
                                          'author': thePost?.author?.userId,
                                          "body": commentBody ?? "",
                                        },
                                        action: (x) async {
                                          await _commentThisProfile();
                                          commentBody = "";
                                          setState(() {});
                                          _pagingController.refresh();
                                        },
                                        text: "Comment",
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

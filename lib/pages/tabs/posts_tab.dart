import 'package:chat_line/layout/list_and_small_form.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/posts/post_thread.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../models/controllers/post_controller.dart';
import '../../wrappers/loading_button.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({
    super.key,
  });


  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  late List<Post> _postsList = [];
  final PostController postController = PostController.init();

  @override
  initState() {
    super.initState();
    _getPosts().then((listOfPosts) {
      _postsList = listOfPosts;
    });
  }

  Future<List<Post>> _getPosts() async {
    String id = AuthInherited.of(context)?.authController?.loggedInUser?.uid ??"";
    if(id != null && id != "") {
      var thePosts = await postController.getPosts(id);
      if (kDebugMode) {
        print("posts $thePosts");
      }
      return thePosts;
    }
    return [];
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

    postResponse = await postController.createPost(_postBody);

    return postResponse;
  }

  @override
  Widget build(BuildContext context) {
    return ListAndSmallFormLayout(
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
          LoadingButton(
            action: () {
              _makePost(context);
            },
            isLoading: _isPosting,
            text: "Comment",
          )
        ],
      ),
    );
  }
}

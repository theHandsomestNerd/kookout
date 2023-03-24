import 'package:chat_line/layout/list_and_small_form.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/posts/post_thread.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/post_controller.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({
    super.key,
    required this.id,
  });

  final String id;

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
    var thePosts = await postController.getPosts(widget.id ?? "");
    print("extended profile ${thePosts}");
    return thePosts;
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

    Post? aPost;

    postResponse = await postController.createPost(aPost);

    return postResponse;
  }

  @override
  Widget build(BuildContext context) {
    return ListAndSmallFormLayout(
      listChild: PostThread(
        key: ObjectKey(_postsList),
        posts: _postsList ?? [],
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
          MaterialButton(
            color: Colors.red,
            disabledColor: Colors.black12,
            textColor: Colors.white,
            // style: ButtonStyle(
            //     backgroundColor: _isMenuItemsOnly
            //         ? MaterialStateProperty.all(Colors.red)
            //         : MaterialStateProperty.all(Colors.white)),
            onPressed: _isPosting != true
                ? () {
                    _makePost(context);
                  }
                : null,
            child: SizedBox(
              height: 48,
              child: _isPosting == true ? Text("Posting...") : Text("Post"),
            ),
          )
        ],
      ),
    );
  }
}

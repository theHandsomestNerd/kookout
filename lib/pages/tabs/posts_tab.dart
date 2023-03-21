import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/post_thread.dart';
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
    _getPosts().then((listOfPosts){
      _postsList = listOfPosts;
    });
  }

  Future<List<Post>> _getPosts() async {
    var thePosts = await postController.getPosts(widget.id ?? "");
    print("extended profile ${thePosts}");
    return thePosts;
  }

  // void _setPostBody(String newPostBody) {
  //   setState(() {
  //     _commentBody = newPostBody;
  //   });
  // }

  _makePost(context) async {
    String? postResponse;

    Post? aPost;

    postResponse = await postController.createPost(aPost);

    return postResponse;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: PostThread(
              key: ObjectKey(_postsList),
              posts: _postsList ?? [],
            ),
          ),
          Flexible(
            flex: 1,
            child: TextFormField(
              // key: ObjectKey(
              //     "${widget.chatController.extProfile?.iAm}-comment-body"),
              // controller: _longBioController,
              // initialValue: widget.chatController.extProfile?.iAm ?? "",
              onChanged: (e) {
                // Create post here
              },
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Post:',
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              // style: ButtonStyle(
              //     backgroundColor: _isMenuItemsOnly
              //         ? MaterialStateProperty.all(Colors.red)
              //         : MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                _makePost(context);
              },
              child: const Text("Post"),
            ),
          )
        ],
      ),
    );
  }
}

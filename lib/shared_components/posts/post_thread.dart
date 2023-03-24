import 'package:chat_line/models/comment.dart';
import 'package:chat_line/models/post.dart';
import 'package:chat_line/shared_components/posts/post_solo.dart';
import 'package:flutter/material.dart';

import '../comments/comment_solo.dart';

class PostThread extends StatelessWidget {
  PostThread({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [...(posts).map((post) {
            return Column(
              children: [
                PostSolo(post: post),
                Divider()
              ],
            );
          }).toList()],
    );
  }
}

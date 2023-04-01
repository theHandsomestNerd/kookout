import 'package:cookout/models/comment.dart';
import 'package:flutter/material.dart';

import 'comment_solo.dart';

class CommentThread extends StatelessWidget {
  const CommentThread({
    super.key,
    required this.comments,
  });

  final List<Comment> comments;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [...(comments).map((comment) {
            return Column(
              children: [
                CommentSolo(comment: comment),
                const Divider()
              ],
            );
          }).toList()],
    );
  }
}

import 'package:chat_line/shared_components/user_block_text.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/post.dart';
import '../../sanity/image_url_builder.dart';

const POST_IMAGE_SQUARE_SIZE = 250;
class PostSolo extends StatelessWidget {
  const PostSolo({
    super.key,
    required this.post,
  });

  final Post post;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserBlockText(user: post.author),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(38, 0, 0, 0),
                  child: Column(
                    children: [
                      post.mainImage != null
                          ? Image.network(
                        MyImageBuilder()
                            .urlFor(
                            post.mainImage ?? "")
                            ?.height(POST_IMAGE_SQUARE_SIZE)
                            .width(POST_IMAGE_SQUARE_SIZE)
                            .url() ??
                            "",
                        height: POST_IMAGE_SQUARE_SIZE as double
                        ,
                        width: POST_IMAGE_SQUARE_SIZE as double,
                      )
                          : SizedBox(
                        height: POST_IMAGE_SQUARE_SIZE as double,
                        width: POST_IMAGE_SQUARE_SIZE as double,
                      ),
                      Text("${post.body}"),
                      Text((post.publishedAt != null
                          ? timeago.format(post.publishedAt!)
                          : "Forever and a day ago")),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

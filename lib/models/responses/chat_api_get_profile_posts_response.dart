

import '../post.dart';

class ChatApiGetProfilePostsResponse {
  final List<Post> list;

  ChatApiGetProfilePostsResponse({
    required this.list,
  });

  factory ChatApiGetProfilePostsResponse.fromJson(List<dynamic> parsedJson) {
    List<Post> list = <Post>[];

    // if (kDebugMode) {
    //   print("get-posts-response $parsedJson");
    // }

    list = parsedJson.map((i) => Post.fromJson(i)).toList();

    return ChatApiGetProfilePostsResponse(list: list);
  }
}

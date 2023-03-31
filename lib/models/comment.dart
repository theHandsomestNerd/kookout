
import 'package:flutter/foundation.dart';

import 'app_user.dart';

class Comment {
  AppUser? author;
  AppUser? recipient;
  String? id;
  String? commentBody;
  DateTime? publishedAt;

  Comment.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['author'] != null && json['author'] != "null") {
      author = AppUser.fromJson(json["author"]);
    }
    if (json['recipient'] != null && json['recipient'] != "null") {
      recipient = AppUser.fromJson(json["recipient"]);
    }
  if (json['body'] != null && json['body'] != "null") {
      commentBody = json["body"];
    }

    if (json['publishedAt'] != null && json['publishedAt'] != "null") {
      publishedAt = DateTime.parse(json["publishedAt"].toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author?.toJson();
    data['recipient'] = recipient?.toJson();
    data['_id'] = id;
    data['commentBody'] = commentBody;
    data['publishedAt'] = publishedAt;
    return data;
  }

  // @override
  // toString(){
  //   return '\n______________Comment:${id}______________\n'
  //       '\nauthor:${author?.userId} '
  //       '\nrecipient:${recipient?.userId} '
  //       '\ncommentBody:$commentBody '
  //       '\npublishedAt:${publishedAt.toString()} '
  //       '\n-----------------------------\n';
  // }
}

import 'package:chat_line/models/sanity/app_user_ref.dart';

import 'app_user.dart';

class Like {
  AppUser? liker;
  AppUser? likee;
  String? id;
  String? likeCategory;

  Like.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      print("processing id ${json['_id']}");
      id = json["_id"];
    }
    if (json['liker'] != null && json['liker'] != "null") {
      print("processing Liker ${json['liker']}");
      liker = AppUser.fromJson(json["liker"]);
    }
    if (json['likee'] != null && json['likee'] != "null") {
      print("processing likee ${json['likee']}");
      likee = AppUser.fromJson(json["likee"]);
    }
  if (json['likeCategory'] != null && json['likeCategory'] != "null") {
      print("processing likeCategory ${json['likeCategory']}");
      likeCategory = json["likeCategory"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['liker'] = liker?.toJson();
    data['likee'] = likee?.toJson();
    data['_id'] = id;
    data['likeCategory'] = likeCategory;
    return data;
  }

  @override
  toString(){
    return '\n______________Like:${id}______________\n'
        '\nliker:${liker?.userId} '
        '\nlikee:${likee?.userId} '
        '\nlikeCategory:$likeCategory '
        '\n-----------------------------\n';
  }
}

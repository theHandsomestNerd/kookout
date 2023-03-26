
import 'app_user.dart';

class Like {
  AppUser? liker;
  AppUser? likee;
  String? id;
  String? likeCategory;

  Like.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['liker'] != null && json['liker'] != "null") {
      liker = AppUser.fromJson(json["liker"]);
    }
    if (json['likee'] != null && json['likee'] != "null") {
      likee = AppUser.fromJson(json["likee"]);
    }
  if (json['likeCategory'] != null && json['likeCategory'] != "null") {
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

  // @override
  // toString(){
  //   return '\n______________Like:${id}______________\n'
  //       '\nliker:${liker?.userId} '
  //       '\nlikee:${likee?.userId} '
  //       '\nlikeCategory:$likeCategory '
  //       '\n-----------------------------\n';
  // }
}

import 'package:chat_line/models/sanity/app_user_ref.dart';

import 'app_user.dart';

class Follow {
  AppUser? follower;
  AppUser? followed;
  String? id;

  Follow.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['follower'] != null && json['follower'] != "null") {
      follower = AppUser.fromJson(json["follower"]);
    }
    if (json['followed'] != null && json['followed'] != "null") {
      followed = AppUser.fromJson(json["followed"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['follower'] = follower?.toJson();
    data['followed'] = followed?.toJson();
    data['_id'] = id;
    return data;
  }

  // @override
  // toString(){
  //   return '\n______________Follow:${id}______________\n'
  //       '\nfollower:${follower?.userId} '
  //       '\nfollowed:${followed?.userId} '
  //       '\n-----------------------------\n';
  // }
}

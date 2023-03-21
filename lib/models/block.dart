import 'package:chat_line/models/sanity/app_user_ref.dart';

import 'app_user.dart';

class Block {
  AppUser? blocker;
  AppUser? blocked;
  String? id;

  Block.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['blocker'] != null && json['blocker'] != "null") {
      blocker = AppUser.fromJson(json["blocker"]);
    }
    if (json['blocked'] != null && json['blocked'] != "null") {
      blocked = AppUser.fromJson(json["blocked"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blocker'] = blocker?.toJson();
    data['blocked'] = blocked?.toJson();
    data['_id'] = id;
    return data;
  }

  // @override
  // toString(){
  //   return '\n______________Block:${id}______________\n'
  //       '\nblocker:${blocker?.userId} '
  //       '\nblocked:${blocked?.userId} '
  //       '\n-----------------------------\n';
  // }
}

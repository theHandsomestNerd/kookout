import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

class AuthUser {
  String? email;
  String? displayName;
  String? uid;
  String? profileURL;

  // LoginProvider? loginProvider;

  AuthUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    displayName = json['displayName'];
    profileURL = json['profileURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = displayName;
    data['2'] = email;
    data['3'] = displayName;
    data['4'] = uid;
    // data['5'] = loginProvider;
    return data;
  }

  // @override
  // String toString() {
  //   return '\n_____________Auth user________________\n'
  //       '\nname:$displayName '
  //       '\nemail:$email '
  //       '\nuserId:$uid '
  //       '\ndisplayname:${displayName} '
  //       '\n-----------------------------\n';
  // }
}

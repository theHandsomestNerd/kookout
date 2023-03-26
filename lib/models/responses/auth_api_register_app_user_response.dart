import 'package:flutter/foundation.dart';

import '../Profile.dart';

class AuthApiRegisterAppUserResponse {
  final Profile profile;

  AuthApiRegisterAppUserResponse({
    required this.profile,
  });

  factory AuthApiRegisterAppUserResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("authregisterAppUserresponse ${json["profile"]}");
    }

    Profile profile = json["profile"];

    return AuthApiRegisterAppUserResponse(profile: profile);
  }
}

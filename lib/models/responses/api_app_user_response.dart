import 'package:flutter/foundation.dart';

import '../Profile.dart';

class ApiAppUserResponse {
  final Profile profile;

  ApiAppUserResponse({
    required this.profile,
  });

  factory ApiAppUserResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("authregisterAppUserresponse ${json["profile"]}");
    }

    Profile profile = json["profile"];

    return ApiAppUserResponse(profile: profile);
  }
}

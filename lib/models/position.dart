import 'dart:core';

import 'app_user.dart';

class SanityPosition {
  AppUser? userRef;
  String? id;
  String? longitude;
  String? latitude;
  String? timestamp;
  String? accuracy;
  String? altitude;
  String? heading;
  String? speed;
  String? speedAccuracy;
  String? floor;

  SanityPosition.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['userRef'] != null && json['userRef'] != "null") {
      userRef = AppUser.fromJson(json["userRef"]);
    }
    if (json['longitude'] != null && json['longitude'] != "null") {
      longitude = json["longitude"];
    }
  if (json['latitude'] != null && json['latitude'] != "null") {
      latitude = json["latitude"];
    }
  if (json['timestamp'] != null && json['timestamp'] != "null") {
      timestamp = json["timestamp"];
    }
    // if (json['timestamp'] != null && json['timestamp'] != "null") {
    //   timestamp = DateTime.parse(json["timestamp"].toString());
    // }
  if (json['accuracy'] != null && json['accuracy'] != "null") {
      accuracy = json["accuracy"];
    }
  if (json['altitude'] != null && json['altitude'] != "null") {
      altitude = json["altitude"];
    }
  if (json['heading'] != null && json['heading'] != "null") {
      heading = json["heading"];
    }
  if (json['speed'] != null && json['speed'] != "null") {
      speed = json["speed"];
    }
  if (json['speedAccuracy'] != null && json['speedAccuracy'] != "null") {
      speedAccuracy = json["speedAccuracy"];
    }
  if (json['floor'] != null && json['floor'] != "null") {
      floor = json["floor"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userRef'] = userRef?.toJson();
    data['longitude'] = longitude;
    data['_id'] = id;
    data['latitude'] = latitude;
    data['accuracy'] = accuracy;
    data['altitude'] = altitude;
    data['floor'] = floor;
    data['speed'] = speed;
    data['speedAccuracy'] = speedAccuracy;
    data['timestamp'] = timestamp;
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

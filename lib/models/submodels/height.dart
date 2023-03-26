import 'package:flutter/foundation.dart';

class Height {
  int? feet;
  int? inches;

  Height(){
    feet = null;
    inches = null;
  }


  Height.withValues(initFeet, initInches){
    feet = initFeet;
    inches = initInches;
  }

  Height.fromJson(Map<String, dynamic> json) {
    if(json['feet'] != null && json['feet'] != "null") {
      if (kDebugMode) {
        print("processing Feet ${json['feet']}");
      }
        feet = json["feet"];
    }
    if(json['inches'] != null && json['inches'] != "null") {
      if (kDebugMode) {
        print("processing inches ${json['inches']}");
      }
        inches = json["inches"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feet'] = feet;
    data['inches'] = inches;
    return data;
  }
}
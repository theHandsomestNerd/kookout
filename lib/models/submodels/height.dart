class Height {
  int? feet = null;
  int? inches = null;

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
      print("processing Feet ${json['feet']}");
        feet = json["feet"];
    }
    if(json['inches'] != null && json['inches'] != "null") {
      print("processing inches ${json['inches']}");
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
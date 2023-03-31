
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
        feet = json["feet"];
    }
    if(json['inches'] != null && json['inches'] != "null") {
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
class Hashtag {
  String? id;
  String? tag;
  int? start;
  int? end;

  Hashtag.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null && json['_id'] != "null") {
      id = json["_id"];
    }
    if (json['tag'] != null && json['tag'] != "null") {
      tag = json["tag"];
    }
    if (json['start'] != null && json['start'] != "null") {
      start = json["start"];
    }
    if (json['end'] != null && json['end'] != "null") {
      end = json["end"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['start'] = start;
    data['_id'] = id;
    data['end'] = end;
    return data;
  }

// @override
// toString(){
//   return '\n______________Hashtag
//   :${id}______________\n'
//       '\nliker:${liker?.userId} '
//       '\nlikee:${likee?.userId} '
//       '\nlikeCategory:$likeCategory '
//       '\n-----------------------------\n';
// }
}

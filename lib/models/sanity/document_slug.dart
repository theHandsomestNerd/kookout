

class DocumentSlug {
  String? current;

  DocumentSlug.fromJson(Map<String, dynamic> json) {
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    return data;
  }
}

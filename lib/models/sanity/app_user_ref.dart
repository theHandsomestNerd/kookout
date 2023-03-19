

class AppUserRef {
  String? ref;

  AppUserRef.fromJson(Map<String, dynamic> json) {
    ref = json['_ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_ref'] = ref;
    return data;
  }
}

class Profile {
  String? displayName;
  String? email;
  String? photoURL;

  Profile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = displayName;
    data['2'] = email;
    data['3'] = photoURL;
    return data;
  }

  @override
  String toString() {
    return '\n______________Profile______________\n'
        '\nname:$displayName '
        '\nemail:$email '
        '\nphotoURL:$photoURL '
        '\n-----------------------------\n';
  }
}

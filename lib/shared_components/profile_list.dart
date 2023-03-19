import 'package:chat_line/shared_components/profile_solo.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class ProfileList extends StatelessWidget {
  ProfileList({
    super.key,
    required this.profiles,
  }){
    print(profiles);
  }

  final List<AppUser>? profiles;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: ObjectKey(profiles),
      width: 900,
      height: 900,
      child: SingleChildScrollView(
        child: Wrap(
          children: (profiles ?? []).map((profile) {
              return ProfileSolo(profile: profile);
            }).toList()
        ),
      ),
    );
  }
}

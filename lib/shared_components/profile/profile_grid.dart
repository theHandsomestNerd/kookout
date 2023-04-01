import 'package:cookout/shared_components/profile/profile_solo.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';

class ProfileGrid extends StatelessWidget {
  const ProfileGrid({
    super.key,
    required this.profiles,
  });

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

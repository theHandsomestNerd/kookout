import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../sanity/image_url_builder.dart';

class ProfileSolo extends StatelessWidget {
  const ProfileSolo({
    super.key,
    required this.profile,
  });

  final AppUser profile;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
          Navigator.pushNamed(context, '/profile',arguments: {"id":profile.userId} );
      },
      child: Stack(
        children: [
          profile.profileImage != null ?Image.network(MyImageBuilder()
            .urlFor(profile.profileImage)
            ?.height(200)
            .width(200)
            .url() ??
            ""):Image.asset(height: 200,width: 200,'assets/blankProfileImage.png'),
          Text("${profile.displayName}")],
      ),
    );
  }
}

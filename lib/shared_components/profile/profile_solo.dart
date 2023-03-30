import 'package:chat_line/wrappers/card_with_background.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
    return InkWell(
      key: super.key,
      onTap: () {
        print("Going to profile ${profile.userId}");
        // Navigator.of(context).push(MaterialPageRoute<void>(
        //
        // ));
        Navigator.pushNamed(context, '/profile',
            arguments: {"id": profile.userId});
      },
      child: Hero(
        tag: profile.userId??"whatever",
        child: Stack(
          children: [
            profile.profileImage != null
                ?  CardWithBackground(
                      height: 200,
                      width: 200,
                      image: NetworkImage(MyImageBuilder()
                              .urlFor(profile.profileImage)
                      ?.width(200)
                      .height(200)
                              .url() ??
                          ""),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${profile.displayName}"),
                      ),
                    )
                : CardWithBackground(
                    height: 200,
                    width: 200,
                    image: const AssetImage('assets/blankProfileImage.png'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${profile.displayName}"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

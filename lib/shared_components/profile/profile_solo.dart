import 'package:chat_line/wrappers/card_with_background.dart';
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
    return InkWell(
      key: super.key,
      onTap: () {
        Navigator.pushNamed(context, '/profile',
            arguments: {"id": profile.userId});
      },
      child: Hero(
        tag: profile.userId??"whatever",
        child: Stack(
          children: [
            profile.profileImage != null
                ?  SizedBox(
                        height: 200,
                        width: 200,

                  child: CardWithBackground(
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
                      ),
                )
                : SizedBox(
                    height: 200,
                    width: 200,
                    child: CardWithBackground(
                      image: const AssetImage('assets/blankProfileImage.png'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${profile.displayName}"),
                      ),
                    ),
                ),
          ],
        ),
      ),
    );
  }
}

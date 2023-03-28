import 'package:chat_line/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../sanity/image_url_builder.dart';

class UserBlockMini extends StatelessWidget {
  const UserBlockMini({
    super.key,
    this.user,
  });

  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: Key((user?.userId ?? "") +
          (user?.displayName ?? "") +
          (user?.profileImage?.toString() ?? "")),
      constraints: const BoxConstraints(),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 48),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                            flex: 4,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/myProfile');
                      },
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 1,
                            child: user?.profileImage != null
                                ? Image.network(
                                    MyImageBuilder()
                                            .urlFor(user?.profileImage ?? "")
                                            ?.height(60)
                                            .width(60)
                                            .url() ??
                                        "",
                                    height: 80,
                                    width: 80,
                                  )
                                : SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                        height: 80,
                                        width: 80,
                                        'assets/blankProfileImage.png'),
                                  ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(child: Text(user?.displayName ?? "", style: Theme.of(context).textTheme.titleSmall,)),
                                // Flexible(child: Text(user?.email ?? ""))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/editProfile');
                          },
                          icon: const Icon(
                            Icons.settings,
                            size: 24.0,
                            semanticLabel: 'Edit Profile',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 24.0,
                        semanticLabel: 'Logout',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

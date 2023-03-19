import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:chat_line/shared_components/comment_thread.dart';
import 'package:chat_line/shared_components/follows_thread.dart';
import 'package:chat_line/shared_components/likes_thread.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:chat_line/shared_components/tool_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/comment.dart';
import '../../models/follow.dart';
import '../../models/like.dart';
import '../../sanity/image_url_builder.dart';
import '../../shared_components/alert_message_popup.dart';
const PROFILE_IMAGE_SQUARE_SIZE = 200;

class BioTab extends StatefulWidget {
  const BioTab({
    super.key,
    required this.chatController,
    required this.authController,
    required this.id,
    required this.thisProfile,
    required this.profileLikes,
    required this.updateLikes,
    required this.isThisMe,
    required this.profileComments,
    required this.updateComments,
    required this.updateFollows,
    required this.profileLikedByMe,
    required this.profileFollowedByMe,
    required this.profileFollows,
  });

  final AuthController authController;
  final ChatController chatController;
  final String id;
  final updateLikes;
  final updateComments;
  final updateFollows;
  final List<Like>? profileLikes;
  final List<Comment>? profileComments;
  final AppUser? thisProfile;
  final bool? isThisMe;
  final Like? profileLikedByMe;
  final Follow? profileFollowedByMe;
  final List<Follow>? profileFollows;

  @override
  State<BioTab> createState() => _BioTabState();
}

class _BioTabState extends State<BioTab> {
  late ExtendedProfile? extProfile = null;
  late bool _isLiking = false;
  late bool _isFollowing = false;

  @override
  initState() {
    super.initState();
    _getExtProfile(widget.id ?? "");
  }


  Future<ExtendedProfile?> _getExtProfile(String userId) async {
    var aProfile =
        await widget.chatController.getExtendedProfile(widget.id ?? "");
    print("extended profile ${aProfile}");
    setState(() {
      extProfile = aProfile;
    });
    return aProfile;
  }

  Future<List<Comment>?> _getComments(String userId) async {
    var theComments =
        await widget.chatController.getProfileComments(widget.id ?? "");
    print("extended profile ${theComments}");
    return theComments;
  }

  _likeThisProfile(context) async {
    setState(() {
      _isLiking = true;
    });
    String? likeResponse = null;
    bool isUnlike = false;

    if (widget.profileLikedByMe == null) {
      likeResponse = await widget.chatController.likeProfile(widget.id);
    } else {
      print("sending to server to unlike ${widget.profileLikedByMe}");
      if (widget.profileLikedByMe != null) {
        isUnlike = true;
        likeResponse = await widget.chatController
            .unlikeProfile(widget.id, widget.profileLikedByMe!);
      }
    }

    return widget.updateLikes(context, likeResponse, isUnlike);
  }

  _followThisProfile(context) async {
    setState(() {
      _isFollowing = true;
    });
    String? followResponse;
    bool isUnfollow = false;

    if (widget.profileFollowedByMe == null) {
      followResponse = await widget.chatController.followProfile(widget.id);
    } else {
      print("sending to server to unfollow ${widget.profileFollowedByMe}");
      if (widget.profileFollowedByMe != null) {
        isUnfollow = true;
        followResponse = await widget.chatController
            .unfollowProfile(widget.id, widget.profileFollowedByMe!);
      }
    }

    return widget.updateFollows(context, followResponse, isUnfollow);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  title: ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.thisProfile?.profileImage != null
                            ? Image.network(
                                MyImageBuilder()
                                        .urlFor(
                                            widget.thisProfile?.profileImage ?? "")
                                        ?.height(PROFILE_IMAGE_SQUARE_SIZE)
                                        .width(PROFILE_IMAGE_SQUARE_SIZE)
                                        .url() ??
                                    "",
                                height: PROFILE_IMAGE_SQUARE_SIZE as double
                          ,
                                width: PROFILE_IMAGE_SQUARE_SIZE as double,
                              )
                            : SizedBox(
                                height: PROFILE_IMAGE_SQUARE_SIZE as double,
                                width: PROFILE_IMAGE_SQUARE_SIZE as double,
                              ),
                        Flexible(
                          key: ObjectKey(widget.profileLikes),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ToolButton(
                                key: ObjectKey("${widget.profileLikes}-likes"),
                                action: _likeThisProfile,
                                iconData: Icons.thumb_up,
                                color: Colors.green,
                                isLoading: _isLiking,
                                text: widget.profileLikes?.length.toString(),
                                label: 'Like',
                                isActive: widget.profileLikedByMe != null,
                              ),
                              ToolButton(
                                  action: _followThisProfile,
                                  text: widget.profileFollows?.length.toString(),
                                  isActive: widget.profileFollowedByMe != null,
                                  iconData: Icons.favorite,
                                  isLoading: _isFollowing,
                                  color: Colors.blue,
                                  label: 'Follow'),
                              ToolButton(
                                  key: ObjectKey("${widget.profileComments}-comments"),
                                  text: widget.profileComments?.length.toString(),
                                  action: (context) {},
                                  iconData: Icons.comment,
                                  color: Colors.yellow,
                                  label: 'Comment'),
                              // ToolButton(
                              //     action: _dislikeThisProfile,
                              //     iconData: Icons.comment,
                              //     color: Colors.red,
                              //     label: 'Dislike'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Name"),
                            Text(widget.thisProfile?.displayName ?? ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text("Age"),
                              Text(extProfile?.age.toString() ?? ""),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text("Weight"),
                              Text(extProfile?.weight.toString() ?? ""),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text("Height"),
                                  Text(("${extProfile?.height?.feet}'") ?? ""),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(""),
                                  Text("${extProfile?.height?.inches}\""),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: const [
                            Text("Short Bio"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(extProfile?.shortBio ?? ""),
                ),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("Long Bio")],
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Text(extProfile?.longBio ?? ""),
                    ),
                  ],
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.iAm ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("I am")],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.imInto ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("I'm Into")],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.imOpenTo ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("I'm Open to")],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.whatIDo ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("What I do")],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.whatImLookingFor ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("What I'm looking for")],
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  subtitle: Text(extProfile?.whatInterestsMe ?? ""),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const [Text("What Interests me")],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: const [
                            Text("Where I Live?"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(extProfile?.whereILive ?? ""),
                ),
                ListTile(
                  title: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: const [
                            Text("Sex Preferences?"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(extProfile?.sexPreferences ?? ""),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

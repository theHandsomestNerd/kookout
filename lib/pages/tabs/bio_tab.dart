import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:chat_line/shared_components/tool_button.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/comment.dart';
import '../../models/controllers/auth_controller.dart';
import '../../models/follow.dart';
import '../../models/like.dart';
import '../../sanity/image_url_builder.dart';

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
    required this.updateBlocks,
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
  final updateBlocks;
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
  late bool _isBlocking = false;

  @override
  initState() {
    super.initState();
    if(widget.id != null) {
      _getExtProfile(widget.id ?? "").then((theExtProfile){
        extProfile = theExtProfile;
      });
    }
  }

  Future<ExtendedProfile?> _getExtProfile(String userId) async {
    var aProfile =
        await widget.chatController.getExtendedProfile(widget.id ?? "");
    print("extended profile ${aProfile}");
    return aProfile;
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

    await widget.updateLikes(context, likeResponse, isUnlike);
    setState(() {
      _isLiking = false;
    });
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

    await widget.updateFollows(context, followResponse, isUnfollow);

    setState(() {
      _isFollowing = false;
    });
  }

  _blockThisProfile(context) async {
    setState(() {
      _isBlocking = true;
    });
    String? blockResponse;

    blockResponse = await widget.chatController.blockProfile(widget.id);
    setState(() {
      _isBlocking = false;
    });

    await widget.updateBlocks(context, blockResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Flex(
        direction: Axis.vertical,
        children: [Expanded(
          flex: 1,
          child: ListView(
            children: [
              ListTile(
                title: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.thisProfile?.profileImage != null
                          ? Expanded(
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  MyImageBuilder()
                                          .urlFor(widget.thisProfile
                                                  ?.profileImage ??
                                              "")
                                          ?.height(
                                              PROFILE_IMAGE_SQUARE_SIZE)
                                          .width(
                                              PROFILE_IMAGE_SQUARE_SIZE)
                                          .url() ??
                                      "",
                                  height:
                                      PROFILE_IMAGE_SQUARE_SIZE as double,
                                  width:
                                      PROFILE_IMAGE_SQUARE_SIZE as double,
                                ),
                              ),
                            )
                          : SizedBox(
                              height:
                                  PROFILE_IMAGE_SQUARE_SIZE as double,
                              width:
                                  PROFILE_IMAGE_SQUARE_SIZE as double,
                            ),
                      SizedBox(
                        width: 150,
                        key: ObjectKey(
                            (widget.profileLikes.toString() ?? "") +
                                (widget.profileFollows.toString() ?? "") +
                                (widget.profileComments.toString() ?? "")),
                        child: Column(
                            children: [
                              Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                              ListTile(
                                title: ToolButton(
                                  isDisabled: (widget.isThisMe == true),
                                  key: ObjectKey(
                                      "${widget.profileLikes}-likes"),
                                  action: _likeThisProfile,
                                  iconData: Icons.thumb_up,
                                  color: Colors.green,
                                  isLoading: _isLiking,
                                  text: widget.profileLikes?.length
                                      .toString(),
                                  label: 'Like',
                                  isActive: widget.profileLikedByMe != null,
                                ),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                              ListTile(
                                key: ObjectKey(
                                    "${widget.profileFollows}-follows"),
                                title: ToolButton(
                                    isDisabled: (widget.isThisMe == true),
                                    action: _followThisProfile,
                                    text: widget.profileFollows?.length
                                        .toString(),
                                    isActive:
                                        widget.profileFollowedByMe != null,
                                    iconData: Icons.favorite,
                                    isLoading: _isFollowing,
                                    color: Colors.blue,
                                    label: 'Follow'),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                              ListTile(
                                title: ToolButton(
                                    isDisabled: (widget.isThisMe == true),
                                    key: ObjectKey(
                                        "${widget.profileComments?.length}-comments"),
                                    text: widget.profileComments?.length
                                        .toString(),
                                    action: (context) {},
                                    iconData: Icons.comment,
                                    color: Colors.yellow,
                                    label: 'Comment'),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                              ListTile(
                                title: ToolButton(
                                  isDisabled: (widget.isThisMe == true),
                                  key: ObjectKey(widget
                                      .chatController.myBlockedProfiles),
                                  action: _blockThisProfile,
                                  iconData: Icons.block,
                                  color: Colors.red,
                                  isLoading: _isBlocking,
                                  text: "Block",
                                  label: 'Block',
                                  isActive: widget.chatController
                                      .isProfileBlockedByMe(widget.id),
                                ),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 2,
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
                    children: [
                      Text(
                        widget.thisProfile?.displayName ?? "",
                        style: Theme.of(context).textTheme.headlineLarge,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            size: 32.0,
                            semanticLabel: "Location",
                          ),
                          Text('mi. away'),
                        ],
                      ),
                      if (extProfile?.whereILive?.isNotEmpty == true)
                        Column(
                          children: [
                            ConstrainedBox(
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
                            Text(extProfile?.whereILive ?? ""),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              ListTile(
                title: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (extProfile?.age != null &&
                          ((extProfile?.age ?? 0) > 0) == true)
                        Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${extProfile?.age.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  Text(
                                    "years",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (extProfile?.height != null &&
                              ((extProfile?.height?.feet ?? 0) > 0) ==
                                  true ||
                          (extProfile?.height?.inches ?? 0) > 0 == true)
                        Flexible(
                          child: Row(
                            children: [
                              Text(
                                ("${extProfile?.height?.feet}'") ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                              Text(""),
                              Text(
                                "${extProfile?.height?.inches}\"",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                            ],
                          ),
                        ),
                      if (extProfile?.weight != null &&
                          ((extProfile?.weight ?? 0) > 0) == true)
                        Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${extProfile?.weight.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  Text(
                                    " lbs",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              if (extProfile?.shortBio?.isNotEmpty == true)
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
              if (extProfile?.longBio?.isNotEmpty == true)
                ListTile(
                  title: Column(
                    children: const [Text("Long Bio")],
                  ),
                  subtitle: Text(extProfile?.longBio ?? ""),
                ),
              if (extProfile?.iAm?.isNotEmpty == true)
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
              if (extProfile?.imInto?.isNotEmpty == true)
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
              if (extProfile?.imOpenTo?.isNotEmpty == true)
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
              if (extProfile?.whatIDo?.isNotEmpty == true)
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
              if (extProfile?.whatImLookingFor?.isNotEmpty == true)
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
              if (extProfile?.whatInterestsMe?.isNotEmpty == true)
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
              if (extProfile?.sexPreferences?.isNotEmpty == true)
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
        ),]
      ),
    );
  }
}

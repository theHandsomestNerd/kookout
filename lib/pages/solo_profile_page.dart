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

import '../models/app_user.dart';
import '../models/comment.dart';
import '../models/follow.dart';
import '../models/like.dart';
import '../sanity/image_url_builder.dart';
import '../shared_components/alert_message_popup.dart';

class SoloProfilePage extends StatefulWidget {
  const SoloProfilePage(
      {super.key,
      required this.chatController,
      required this.authController,
      required this.drawer,
      required this.id});

  final AuthController authController;
  final ChatController chatController;
  final Widget drawer;
  final String id;

  @override
  State<SoloProfilePage> createState() => _SoloProfilePageState();
}

class _SoloProfilePageState extends State<SoloProfilePage> {
  late AppUser? _thisProfile = null;
  late ExtendedProfile? extProfile = null;
  late List<Comment>? _profileComments = null;
  late Like? _profileLikedByMe = null;
  late List<Like>? _profileLikes = null;
  late bool _isLiking = false;
  late bool _isCommenting = false;
  late bool _isThisMe = false;
  late String? _commentBody = null;
  late Follow? _profileFollowedByMe = null;
  late List<Follow>? _profileFollows = null;
  late bool _isFollowing = false;

  @override
  initState() {
    super.initState();

    _isThisMe = widget.id == widget.authController.loggedInUser?.uid;

    _getAppUser(widget.id ?? "");
    _getExtProfile(widget.id ?? "");

    _getComments(widget.id ?? "").then((theComments) {
      _profileComments = theComments;
    });

    _getProfileLikes().then((theLikes) {
      _profileLikes = theLikes;
      _profileLikedByMe = isThisProfileLikedByMe(theLikes);
    });

    _getProfileFollows().then((theFollows) {
      _profileFollows = theFollows;
      _profileFollowedByMe = isThisProfileFollowedByMe(theFollows);
    });
  }

  Future<AppUser?> _getAppUser(String userId) async {
    var aProfile = await widget.authController.getAppUser(widget.id ?? "");
    print("compled in consteucrto ${aProfile}");
    setState(() {
      _thisProfile = aProfile;
    });
    return aProfile;
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

  void _setCommentBody(String newCommentBody) {
    setState(() {
      _commentBody = newCommentBody;
    });
  }

  // _showCommentDialog(context) async {
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext innerContext) {
  //         return AlertMessagePopup(
  //             isError: false,
  //             isSuccess: false,
  //             title:
  //                 "${_profileComments?.length} comments on ${_thisProfile?.displayName}'s Profile",
  //             children: [
  //               Flexible(
  //                 flex: 8,
  //                 child: CommentThread(
  //                   key: ObjectKey(_profileComments),
  //                   comments: _profileComments ?? [],
  //                 ),
  //               ),
  //               Flexible(
  //                 flex: 1,
  //                 child: TextFormField(
  //                   // key: ObjectKey(
  //                   //     "${widget.chatController.extProfile?.iAm}-comment-body"),
  //                   // controller: _longBioController,
  //                   // initialValue: widget.chatController.extProfile?.iAm ?? "",
  //                   onChanged: (e) {
  //                     _setCommentBody(e);
  //                   },
  //                   minLines: 2,
  //                   maxLines: 4,
  //                   decoration: const InputDecoration(
  //                     border: UnderlineInputBorder(),
  //                     labelText: 'Comment:',
  //                   ),
  //                 ),
  //               ),
  //               Flexible(
  //                 flex: 1,
  //                 child: MaterialButton(
  //                   color: Colors.red,
  //                   textColor: Colors.white,
  //                   // style: ButtonStyle(
  //                   //     backgroundColor: _isMenuItemsOnly
  //                   //         ? MaterialStateProperty.all(Colors.red)
  //                   //         : MaterialStateProperty.all(Colors.white)),
  //                   onPressed: () {
  //                     _commentThisProfile(context);
  //                   },
  //                   child: Text("Leave Comment"),
  //                 ),
  //               ),
  //             ]);
  //       });
  //
  //   List<Comment>? newComments = await _getComments(widget.id);
  //   setState(() {
  //     _profileComments = newComments;
  //   });
  // }

  _getTagLine() {
    if (_isThisMe == true) {
      return "This is you ${widget.authController.myAppUser?.displayName ?? ""}";
    }
    return _thisProfile?.displayName;
  }

  _getProfileLikes() async {
    return widget.chatController.getProfileLikes(widget.id);
  }

  _getProfileFollows() async {
    return widget.chatController.getProfileFollows(widget.id);
  }

  _getProfileComments() async {
    return widget.chatController.getProfileComments(widget.id);
  }

  isThisProfileLikedByMe(List<Like> theLikes) {
    Like? profileLikedByMe;
    for (var like in theLikes) {
      if (like.liker?.userId == widget.authController.loggedInUser?.uid) {
        if (kDebugMode) {
          print("I'm ${widget.authController.loggedInUser?.uid} in the likes?");
        }
        profileLikedByMe = like;
      }
    }

    return profileLikedByMe;
  }

  isThisProfileFollowedByMe(List<Follow> theFollows) {
    Follow? profileFollowedByMe;
    for (var follow in theFollows) {
      if (follow.follower?.userId == widget.authController.loggedInUser?.uid) {
        if (kDebugMode) {
          print(
              "I'm ${widget.authController.loggedInUser?.uid} in the follows?");
        }
        profileFollowedByMe = follow;
      }
    }

    return profileFollowedByMe;
  }

  _likeThisProfile(context) async {
    setState(() {
      _isLiking = true;
    });
    String? likeResponse = null;
    bool isUnlike = false;

    if (_profileLikedByMe == null) {
      likeResponse = await widget.chatController.likeProfile(widget.id);
    } else {
      print("sending to server to unlike $_profileLikedByMe");
      if (_profileLikedByMe != null) {
        isUnlike = true;
        likeResponse = await widget.chatController
            .unlikeProfile(widget.id, _profileLikedByMe!);
      }
    }

    List<Like> theLikes = await _getProfileLikes();

    Like? isLikedResponse = isThisProfileLikedByMe(theLikes);

    setState(() {
      _isLiking = false;
      _profileLikes = theLikes;
      _profileLikedByMe = isLikedResponse;
    });

    if (!isUnlike && likeResponse != "SUCCESS") {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertMessagePopup(
                title: "FAIL",
                message: "That like didnt register. Try Again.",
                isError: true);
          });
    }
    return;
  }

  _followThisProfile(context) async {
    setState(() {
      _isFollowing = true;
    });
    String? followResponse;
    bool isUnfollow = false;

    if (_profileFollowedByMe == null) {
      followResponse = await widget.chatController.followProfile(widget.id);
    } else {
      print("sending to server to unfollow $_profileFollowedByMe");
      if (_profileFollowedByMe != null) {
        isUnfollow = true;
        followResponse = await widget.chatController
            .unfollowProfile(widget.id, _profileFollowedByMe!);
      }
    }

    List<Follow> theFollows = await _getProfileFollows();

    Follow? isFollowedResponse = isThisProfileFollowedByMe(theFollows);

    setState(() {
      _isFollowing = false;
      _profileFollows = theFollows;
      _profileFollowedByMe = isFollowedResponse;
    });

    if (!isUnfollow && followResponse != "SUCCESS") {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const AlertMessagePopup(
                title: "FAIL",
                message: "That like didnt register. Try Again.",
                isError: true);
          });
    }
    return;
  }

  _commentThisProfile(context) async {
    setState(() {
      _isCommenting = true;
    });
    String? commentResponse;

    commentResponse = await widget.chatController
        .commentProfile(widget.id, _commentBody ?? "");

    List<Comment> theComments = await _getProfileComments();

    setState(() {
      _isCommenting = false;
      _profileComments = theComments;
    });

    Navigator.of(context).pop();

    if (commentResponse != "SUCCESS") {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const AlertMessagePopup(
                title: "FAIL",
                message: "That like didnt register. Try Again.",
                isError: true);
          });
    } else {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const AlertMessagePopup(
              title: "SUCCESS",
              message: "Comment Posted.",
              isError: false,
              isSuccess: true,
            );
          });
    }
  }

  _dislikeThisProfile() {}

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _widgetOptions(_selectedIndex) {
    var theOptions = <Widget>[
      Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: ListView(
                children: [
                  // !_isThisMe
                  //     ? ListTile(
                  //         title: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             ToolButton(
                  //               key: ObjectKey("${_profileLikes}-likes"),
                  //               action: _likeThisProfile,
                  //               iconData: Icons.thumb_up,
                  //               color: Colors.green,
                  //               isLoading: _isLiking,
                  //               text: _profileLikes?.length.toString(),
                  //               label: 'Like',
                  //               isActive: _profileLikedByMe != null,
                  //             ),
                  //             ToolButton(
                  //                 action: _followThisProfile,
                  //                 text: _profileFollows?.length.toString(),
                  //                 isActive: _profileFollowedByMe != null,
                  //                 iconData: Icons.favorite,
                  //                 isLoading: _isFollowing,
                  //                 color: Colors.blue,
                  //                 label: 'Follow'),
                  //             ToolButton(
                  //                 key: ObjectKey("$_profileComments-comments"),
                  //                 text: _profileComments?.length.toString(),
                  //                 action: (context) {
                  //                   setState(() {
                  //                     _selectedIndex = 2;
                  //                   });
                  //                 },
                  //                 iconData: Icons.comment,
                  //                 color: Colors.yellow,
                  //                 label: 'Comment'),
                  //             // ToolButton(
                  //             //     action: _dislikeThisProfile,
                  //             //     iconData: Icons.comment,
                  //             //     color: Colors.red,
                  //             //     label: 'Dislike'),
                  //           ],
                  //         ),
                  //       )
                  //     : Text("This is you"),
                  ListTile(
                    title: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _thisProfile?.profileImage != null
                              ? Image.network(
                                  MyImageBuilder()
                                          .urlFor(
                                              _thisProfile?.profileImage ?? "")
                                          ?.height(200)
                                          .width(200)
                                          .url() ??
                                      "",
                                  height: 200,
                                  width: 200,
                                )
                              : SizedBox(
                                  height: 200,
                                  width: 200,
                                ),
                          Flexible(
                            key: ObjectKey(_profileLikes),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ToolButton(
                                  key: ObjectKey("${_profileLikes}-likes"),
                                  action: _likeThisProfile,
                                  iconData: Icons.thumb_up,
                                  color: Colors.green,
                                  isLoading: _isLiking,
                                  text: _profileLikes?.length.toString(),
                                  label: 'Like',
                                  isActive: _profileLikedByMe != null,
                                ),
                                ToolButton(
                                    action: _followThisProfile,
                                    text: _profileFollows?.length.toString(),
                                    isActive: _profileFollowedByMe != null,
                                    iconData: Icons.favorite,
                                    isLoading: _isFollowing,
                                    color: Colors.blue,
                                    label: 'Follow'),
                                ToolButton(
                                    key: ObjectKey("$_profileComments-comments"),
                                    text: _profileComments?.length.toString(),
                                    action: (context) {
                                      setState(() {
                                        _selectedIndex = 2;
                                      });
                                    },
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
                              Text("account name"),
                              Text(_thisProfile?.displayName ?? ""),
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
                                    Text(
                                        ("${extProfile?.height?.feet}'") ?? ""),
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
                            children: [
                              Text("Short Bio"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(extProfile?.shortBio ?? ""),
                  ),
                  ExpansionTile(
                    children: [
                      ListTile(
                        title: Text(extProfile?.longBio ?? ""),
                      ),
                    ],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [Text("Long Bio")],
                        ),
                      ],
                    ),
                  ),
                  ExpansionTile(
                    subtitle: Text(extProfile?.iAm ?? ""),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [Text("I am")],
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
                          children: [Text("I'm Into")],
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
                          children: [Text("I'm Open to")],
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
                          children: [Text("What I do")],
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
                          children: [Text("What I'm looking for")],
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
                          children: [Text("What Interests me")],
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
                            children: [
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
                            children: [
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
      ),
      ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            Flexible(
              flex: 8,
              child: CommentThread(
                key: ObjectKey(_profileComments),
                comments: _profileComments ?? [],
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                // key: ObjectKey(
                //     "${widget.chatController.extProfile?.iAm}-comment-body"),
                // controller: _longBioController,
                // initialValue: widget.chatController.extProfile?.iAm ?? "",
                onChanged: (e) {
                  _setCommentBody(e);
                },
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Comment:',
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                // style: ButtonStyle(
                //     backgroundColor: _isMenuItemsOnly
                //         ? MaterialStateProperty.all(Colors.red)
                //         : MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  _commentThisProfile(context);
                },
                child: Text("Leave Comment"),
              ),
            )
          ],
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: FollowThread(
                key: ObjectKey(_profileFollows),
                follows: _profileFollows ?? [],
              ),
            ),
          ],
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: LikeThread(
                key: ObjectKey(_profileFollows),
                likes: _profileLikes ?? [],
              ),
            ),
          ],
        ),
      ),
      Text(
        'Index 3: Photo',
        style: optionStyle,
      ),
    ];

    return theOptions.elementAt(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ObjectKey(_thisProfile),
      drawer: widget.drawer,
      appBar: AppBar(
        // Here we take the value from the Logout object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Chat Line - ${_getTagLine()}"),
      ),
      body: ConstrainedBox(key: Key(_selectedIndex.toString()),constraints:BoxConstraints(),child: _widgetOptions(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Bio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Follows',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Likes',
          ),
        BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Photos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        unselectedItemColor: Colors.black,
        onTap:
            _onItemTapped, // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

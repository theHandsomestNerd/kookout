import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:chat_line/pages/tabs/bio_tab.dart';
import 'package:chat_line/pages/tabs/comments_tab.dart';
import 'package:chat_line/pages/tabs/follows_tab.dart';
import 'package:chat_line/pages/tabs/likes_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/block.dart';
import '../models/comment.dart';
import '../models/follow.dart';
import '../models/like.dart';
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
  late bool _isThisMe = false;
  late AppUser? _thisProfile=null;
  late ExtendedProfile? extProfile=null;

  late List<Comment>? _profileComments=null;

  late Like? _profileLikedByMe=null;
  late List<Like>? _profileLikes=null;

  late Follow? _profileFollowedByMe=null;
  late List<Follow>? _profileFollows=null;

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
  //                   //     "${ChatController(.extProfile?.iAm}-comment-body"),
  //                   // controller: _longBioController,
  //                   // initialValue: ChatController(.extProfile?.iAm ?? "",
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _widgetOptions(_selectedIndex) {
    var theOptions = <Widget>[
      BioTab(

        thisProfile: _thisProfile,
        id: widget.id,
        updateBlocks: (innercontext, String blockResponse) async {
          // List<Block> theBlocks = await _getProfileBlocks();
          await widget.chatController.updateMyBlocks();

          if (blockResponse != "SUCCESS") {

            return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertMessagePopup(
                      title: "FAIL",
                      message: "That block didnt register. Try Again.",
                      isError: true);
                });
          } else {
            Navigator.popAndPushNamed(context, '/profilesPage');
          }
        },
        profileLikes: _profileLikes,
        profileFollows: _profileFollows,
        updateLikes: (context, String likeResponse, bool isUnlike) async {
          List<Like> theLikes = await _getProfileLikes();
          Like? isLikedResponse = isThisProfileLikedByMe(theLikes);

          setState(() {
            // _isLiking = false;
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
        },
        updateFollows: (context, String followResponse, bool isUnfollow) async {
          List<Follow> theFollows = await _getProfileFollows();
          Follow? isFollowdResponse = isThisProfileFollowedByMe(theFollows);

          setState(() {
            // _isFollowing = false;
            _profileFollows = theFollows;
            _profileFollowedByMe = isFollowdResponse;
          });

          if (!isUnfollow && followResponse != "SUCCESS") {
            return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertMessagePopup(
                      title: "FAIL",
                      message: "That like didnt register. Try Again.",
                      isError: true);
                });
          }
        },
        isThisMe: _isThisMe,
        profileComments: _profileComments,
        updateComments:
            (context, String commentResponse, bool isUncomment) async {
          List<Comment> theComments = await _getProfileComments();

          setState(() {
            // _isCommenting = false;
            _profileComments = theComments;
          });

          if (!isUncomment && commentResponse != "SUCCESS") {
            return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return const AlertMessagePopup(
                      title: "FAIL",
                      message: "That like didnt register. Try Again.",
                      isError: true);
                });
          }
        },
        profileLikedByMe: _profileLikedByMe,
        profileFollowedByMe: _profileFollowedByMe, chatController: widget.chatController,authController: widget.authController,
      ),
      CommentsTab(
          id: widget.id,
          profileComments: _profileComments,
          thisProfile: _thisProfile,
          updateComments: (context, String updateCommentResponse) async {
            List<Comment> theComments =
                await widget.chatController.getProfileComments(widget.id);
            setState(() {
              // _isCommenting = false;
              _profileComments = theComments;
            });

            Navigator.of(context).pop();

            if (updateCommentResponse != "SUCCESS") {
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
          },
          isThisMe: _isThisMe, chatController: widget.chatController, authController: widget.authController,),
      FollowsTab(
        chatController: widget.chatController,
        authController: widget.authController,
        thisProfile: _thisProfile,
        isThisMe: _isThisMe,
        profileFollowedByMe: _profileFollowedByMe,
        profileFollows: _profileFollows,
        id: widget.id,
      ),
      LikesTab(
        chatController: widget.chatController,
        authController: widget.authController,
        thisProfile: _thisProfile,
        isThisMe: _isThisMe,
        profileLikedByMe: _profileLikedByMe,
        profileLikes: _profileLikes,
        id: widget.id,
      ),
      const Text(
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
      body: ConstrainedBox(
          key: Key(_selectedIndex.toString()),
          constraints: BoxConstraints(),
          child: _widgetOptions(_selectedIndex)),
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

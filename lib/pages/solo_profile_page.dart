import 'package:chat_line/models/clients/chat_client.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:chat_line/pages/tabs/bio_tab.dart';
import 'package:chat_line/pages/tabs/comments_tab.dart';
import 'package:chat_line/pages/tabs/follows_tab.dart';
import 'package:chat_line/pages/tabs/likes_tab.dart';
import 'package:chat_line/wrappers/alerts_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/comment.dart';
import '../models/controllers/auth_inherited.dart';
import '../models/follow.dart';
import '../models/like.dart';

class SoloProfilePage extends StatefulWidget {
  const SoloProfilePage({super.key, required this.drawer, required this.id});

  final Widget drawer;
  final String id;

  @override
  State<SoloProfilePage> createState() => _SoloProfilePageState();
}

class _SoloProfilePageState extends State<SoloProfilePage> {
  late bool _isThisMe = false;
  late AppUser? _thisProfile = null;

  late List<Comment>? _profileComments = [];

  late Like? _profileLikedByMe = null;
  late List<Like>? _profileLikes = [];

  late Follow? _profileFollowedByMe = null;
  late List<Follow>? _profileFollows = [];

  AlertSnackbar _alertSnackbar = AlertSnackbar();

  ChatClient? profileClient = null;
  AuthController? authController = null;
  ChatController? chatController = null;

  @override
  initState() {
    super.initState();

    if (widget == null || widget.id == "") {
      Navigator.popAndPushNamed(context, '/profilesPage');
    }
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    var theChatController = AuthInherited.of(context)?.chatController;
    var theAuthController = AuthInherited.of(context)?.authController;
    var theFollows =
        await theChatController?.profileClient.getProfileFollows(widget.id) ??
            [];
    var theLikes =
        await theChatController?.profileClient.getProfileLikes(widget.id) ?? [];
    var theComments =
        await theChatController?.profileClient.getProfileComments(widget.id) ??
            [];

    _profileComments = theComments;
    _profileLikes = theLikes;
    _profileFollows = theFollows;
    _profileFollowedByMe = isThisProfileFollowedByMe(theFollows);
    _profileLikedByMe = isThisProfileLikedByMe(theLikes);
    var theProfile = await theAuthController?.getAppUser(widget.id);
    _thisProfile = theProfile;

    print("the profile retrieved in this page $theProfile");


    profileClient = theChatController?.profileClient;
    authController = theAuthController;

    _isThisMe = widget.id ==
        theAuthController?.loggedInUser?.uid;

    setState(() {});
    print("timeline events dependencies changed ${_thisProfile}");
  }

  // Future<AppUser?> _getAppUser(String userId) async {
  //   var aProfile =
  //       await authController?.getAppUser(widget.id);
  //   if (kDebugMode) {
  //     print("compled in consteucrto $aProfile");
  //   }
  //
  //   return aProfile;
  // }

  // Future<ExtendedProfile?> _getExtProfile(String userId) async {
  //   var aProfile = await widget.chatController.getExtendedProfile(widget.id);
  //   if (kDebugMode) {
  //     print("extended profile $aProfile");
  //   }
  //
  //   return aProfile;
  // }

  Future<List<Comment>?> _getComments(String userId) async {
    var theComments =
        await profileClient?.getProfileComments(widget.id);
    if (kDebugMode) {
      print("the comments $theComments");
    }
    return theComments;
  }

  _getTagLine() {
    if (_isThisMe == true) {
      return "This is you ${authController?.myAppUser?.displayName ?? ""}";
    }
    return _thisProfile?.displayName;
  }

  _getProfileLikes() async {
    return profileClient?.getProfileLikes(widget.id);
  }

  _getProfileFollows() async {
    return profileClient?.getProfileFollows(widget.id);
  }

  _getProfileComments() async {
    return profileClient?.getProfileComments(widget.id);
  }

  isThisProfileLikedByMe(List<Like> theLikes) {
    Like? profileLikedByMe;
    for (var like in theLikes) {
      if (like.liker?.userId ==
          authController?.loggedInUser?.uid) {
        if (kDebugMode) {
          print(
              "I'm ${authController?.loggedInUser?.uid} in the likes?");
        }
        profileLikedByMe = like;
      }
    }

    return profileLikedByMe;
  }

  isThisProfileFollowedByMe(List<Follow> theFollows) {
    Follow? profileFollowedByMe;
    for (var follow in theFollows) {
      if (follow.follower?.userId ==
          authController?.loggedInUser?.uid) {
        if (kDebugMode) {
          print(
              "I'm ${authController?.loggedInUser?.uid} in the follows?");
        }
        profileFollowedByMe = follow;
      }
    }

    return profileFollowedByMe;
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _widgetOptions(selectedIndex) {
    var theOptions = <Widget>[
      BioTab(
        // key: ObjectKey((_profileLikes?.length.toString() ?? "0-likes") +
        //     (_profileFollows?.length.toString() ?? "0-follows") +
        //     (_profileComments?.length.toString() ?? "0-comments")),
        thisProfile: _thisProfile,
        profileLikes: _profileLikes,
        id: widget.id,
        updateBlocks: (innercontext, String blockResponse) async {
          // List<Block> theBlocks = await _getProfileBlocks();
          await chatController?.updateMyBlocks();

          if (blockResponse != "SUCCESS") {
            _alertSnackbar.showErrorAlert(
                "That block didnt register. Try Again.", context);
          } else {
            _alertSnackbar.showSuccessAlert(
                "You blocked this user. Ew!", context);

            Navigator.popAndPushNamed(innercontext, '/profilesPage');
          }
        },
        profileFollows: _profileFollows,
        updateLikes: (innerContext, String likeResponse, bool isUnlike) async {
          List<Like> theLikes = await _getProfileLikes();
          Like? isLikedResponse = isThisProfileLikedByMe(theLikes);

          setState(() {
            _profileLikes = theLikes;
            _profileLikedByMe = isLikedResponse;
          });

          if (!isUnlike && likeResponse != "SUCCESS") {
            _alertSnackbar.showErrorAlert(
                "That ${isUnlike ? "unlike" : "like"} didnt register. Try Again.",
                innerContext);
          } else {
            _alertSnackbar.showSuccessAlert(
                "You liked this profile.", innerContext);
          }
        },
        updateFollows:
            (innerContext, String followResponse, bool isUnfollow) async {
          List<Follow> theFollows = await _getProfileFollows();
          Follow? isFollowdResponse = isThisProfileFollowedByMe(theFollows);

          setState(() {
            _profileFollows = theFollows;
            _profileFollowedByMe = isFollowdResponse;
          });

          if (followResponse != "SUCCESS") {
            _alertSnackbar.showErrorAlert(
                "That ${isUnfollow == true ? "Unfollow" : "Follow"} didnt register. Try Again.",
                innerContext);
          } else {
            _alertSnackbar.showSuccessAlert(
                "You ${isUnfollow == true ? "Unfollowed" : "Followed"} the user.",
                innerContext);
          }
        },
        isThisMe: _isThisMe,
        profileComments: _profileComments,
        updateComments:
            (innerContext, String commentResponse, bool isUncomment) async {
          List<Comment> theComments = await _getProfileComments();

          setState(() {
            // _isCommenting = false;
            _profileComments = theComments;
          });

          if (commentResponse != "SUCCESS") {
            _alertSnackbar.showErrorAlert(
                "That ${isUncomment == true ? "Uncomment" : "Comment"} didnt register. Try Again.",
                innerContext);
          } else {
            _alertSnackbar.showSuccessAlert(
                "That ${isUncomment == true ? "Uncomment" : "Comment"} ",
                innerContext);
          }
        },
        profileLikedByMe: _profileLikedByMe,
        profileFollowedByMe: _profileFollowedByMe,
      ),
      CommentsTab(
        key: ObjectKey(_profileComments),
        id: widget.id,
        profileComments: _profileComments,
        thisProfile: _thisProfile,
        updateComments: (innerContext, String updateCommentResponse) async {
          List<Comment> theComments = await profileClient?.getProfileComments(widget.id) ?? [];
          setState(() {
            _profileComments = theComments;
          });

          if (updateCommentResponse != "SUCCESS") {
            _alertSnackbar.showErrorAlert(
                "That like didnt register. Try Again.", innerContext);
          } else {
            _alertSnackbar.showSuccessAlert("Comment Posted.", innerContext);
          }
        },
        isThisMe: _isThisMe,
      ),
      FollowsTab(
        thisProfile: _thisProfile,
        isThisMe: _isThisMe,
        profileFollowedByMe: _profileFollowedByMe,
        profileFollows: _profileFollows,
        id: widget.id,
      ),
      LikesTab(
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

    return theOptions.elementAt(selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        // Here we take the value from the Logout object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Chat Line - ${_getTagLine()}"),
      ),
      // body: Center(child: Text("just text")),
      body: Center(
        key: Key(_selectedIndex.toString()),
        child: Flex(
            key: ObjectKey(widget.id),
            direction: Axis.vertical,
            children: [
              Expanded(
                  child: widget.id != null
                      ? _widgetOptions(_selectedIndex)
                      : Text("No Profile ID"))
            ]),
      ),
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

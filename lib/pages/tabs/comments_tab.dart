import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/shared_components/comment_thread.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/comment.dart';

class CommentsTab extends StatefulWidget {
  const CommentsTab(
      {super.key,
      required this.chatController,
      required this.authController,
      required this.id,
      required this.profileComments,
      required this.thisProfile,
        required this.updateComments,
      required this.isThisMe});

  final AuthController authController;
  final ChatController chatController;
  final List<Comment>? profileComments;
  final AppUser? thisProfile;
  final String id;
  final bool isThisMe;
  final  updateComments;

  @override
  State<CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<CommentsTab> {
  late String? _commentBody = null;

  @override
  initState() {
    super.initState();
  }

  // Future<List<Comment>?> _getComments(String userId) async {
  //   var theComments =
  //       await widget.chatController.getProfileComments(widget.id ?? "");
  //   print("extended profile ${theComments}");
  //   return theComments;
  // }

  void _setCommentBody(String newCommentBody) {
    setState(() {
      _commentBody = newCommentBody;
    });
  }


  _commentThisProfile(context) async {
    String? commentResponse;

    commentResponse = await widget.chatController
        .commentProfile(widget.id, _commentBody ?? "");

    widget.updateComments(context, commentResponse);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: CommentThread(
              key: ObjectKey(widget.profileComments),
              comments: widget.profileComments ?? [],
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
              child: const Text("Leave Comment"),
            ),
          )
        ],
      ),
    );
  }
}

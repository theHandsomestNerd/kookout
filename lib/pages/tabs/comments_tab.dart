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
  final updateComments;

  @override
  State<CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<CommentsTab> {
  late String? _commentBody = null;
  bool isCommenting = false;

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
    setState(() {
      isCommenting = true;
    });
    String? commentResponse;

    commentResponse = await widget.chatController
        .commentProfile(widget.id, _commentBody ?? "");

    await widget.updateComments(context, commentResponse);
    setState(() {
      isCommenting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: CommentThread(
                key: ObjectKey(widget.profileComments),
                comments: widget.profileComments ?? [],
              ),
            ),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
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
                  MaterialButton(
                    color: Colors.red,
                    disabledColor: Colors.black12,
                    textColor: Colors.white,
                    onPressed: !isCommenting
                        ? () {
                            _commentThisProfile(context);
                          }
                        : null,
                    child: SizedBox(
                      height: 48,
                      child: InkWell(
                        child: isCommenting
                            ? Text("Posting comment...")
                            : Text("Leave Comment"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

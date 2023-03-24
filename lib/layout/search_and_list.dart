import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/shared_components/comments/comment_thread.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/comment.dart';
import '../shared_components/search_box.dart';

class SearchAndList extends StatefulWidget {
  const SearchAndList({
    super.key,
    required this.listChild,
    this.isSearchEnabled,
  });

  final Widget listChild;
  final bool? isSearchEnabled;

  @override
  State<SearchAndList> createState() => _SearchAndListState();
}

class _SearchAndListState extends State<SearchAndList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(direction: Axis.vertical, children: [
        widget.isSearchEnabled != false
            ? SizedBox(
                height: 100,
                child: SearchBox(
                  searchTerms: "",
                  setTerms: () {},
                ),
              )
            : Text(""),
        Expanded(
          child: widget.listChild,
        ),
      ]),
    );
  }
}

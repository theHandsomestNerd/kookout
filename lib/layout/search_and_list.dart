import 'package:flutter/material.dart';

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
            : const Text(""),
        Expanded(
          child:  widget.listChild,
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kookout/models/clients/api_client.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../wrappers/loading_button.dart';
import '../models/controllers/auth_inherited.dart';

class ChapterMemberContent extends StatefulWidget {
  const ChapterMemberContent({Key? key, required this.chapterMember})
      : super(key: key);
  final PlutoRow chapterMember;

  @override
  State<ChapterMemberContent> createState() => _ChapterMemberContentState();
}

class _ChapterMemberContentState extends State<ChapterMemberContent> {
  ApiClient? client;

  @override
  didChangeDependencies() async {
    var theClient = AuthInherited.of(context)?.chatController?.profileClient;
    if (theClient != null) {
      client = theClient;
    }

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // key: ObjectKey(isSubmitting),
      // backgroundColor: Colors.green,
      title: Column(
        children: [
          Text('Member ${widget.chapterMember.cells['spreadsheetId']?.value}'),
          if (widget.chapterMember.cells['chapterAffiliation']?.value != null &&
              widget.chapterMember.cells['chapterAffiliation']?.value != "")
            Text(
              widget.chapterMember.cells['chapterAffiliation']?.value,
              style: TextStyle(fontSize: 12),
            ),
        ],
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${widget.chapterMember.cells['firstName']?.value} ${widget.chapterMember.cells['middleName']?.value} ${widget.chapterMember.cells['lastName']?.value != "" ? "${widget.chapterMember.cells['lastName']?.value}" : ""}"),
                    if (widget.chapterMember.cells['nickName']?.value != null &&
                        widget.chapterMember.cells['nickName']?.value != "")
                      Text("${widget.chapterMember.cells['nickName']?.value}"),
                    if (widget.chapterMember.cells['occupation']?.value !=
                            null &&
                        widget.chapterMember.cells['occupation']?.value != "")
                      Text(
                          "${widget.chapterMember.cells['occupation']?.value}"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (widget.chapterMember.cells['status']
                              ?.value['isChapterInvisible'] !=
                          null &&
                      widget.chapterMember.cells['status']
                              ?.value['isChapterInvisible'] !=
                          false)
                    Text("Chapter Invisible"),
                  if (widget.chapterMember.cells['status']
                          ?.value['isOnTheYard'] ==
                      true)
                    Text("On The Yard"),
                  if (widget.chapterMember.cells['status']
                              ?.value['onCampusOffice'] !=
                          null &&
                      widget.chapterMember.cells['status']
                              ?.value['onCampusOffice'] !=
                          "")
                    Text(widget.chapterMember.cells['status']
                        ?.value['onCampusOffice']),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.chapterMember.cells['email']?.value != null &&
                        widget.chapterMember.cells['email']?.value != "")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.chapterMember.cells['email']?.value
                            .map<Widget>((emailAddy) {
                          return Text(emailAddy);
                        }).toList(),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.chapterMember.cells['phoneNumbers']
                                    ?.value['cellNumber'] !=
                                null &&
                            widget.chapterMember.cells['phoneNumbers']
                                    ?.value['cellNumber'] !=
                                "")
                          Text(
                              "cell: ${widget.chapterMember.cells['phoneNumbers']?.value['cellNumber']}"),
                        if (widget.chapterMember.cells['phoneNumbers']
                                    ?.value['homeNumber'] !=
                                null &&
                            widget.chapterMember.cells['phoneNumbers']
                                    ?.value['homeNumber'] !=
                                "")
                          Text(
                              "home: ${widget.chapterMember.cells['phoneNumbers']?.value['homeNumber']}"),
                        if (widget.chapterMember.cells['phoneNumbers']
                                    ?.value['workNumber'] !=
                                null &&
                            widget.chapterMember.cells['phoneNumbers']
                                    ?.value['workNumber'] !=
                                "")
                          Text(
                              "work: ${widget.chapterMember.cells['phoneNumbers']?.value['workNumber']}"),
                      ],
                    ),
                    if (widget.chapterMember.cells['address']?.value != null)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.chapterMember.cells['address']
                                        ?.value['address'] !=
                                    null &&
                                widget.chapterMember.cells['address']
                                        ?.value['address'] !=
                                    "")
                              if (widget.chapterMember.cells['address']
                                          ?.value['address'] !=
                                      null &&
                                  widget.chapterMember.cells['address']
                                          ?.value['address'] !=
                                      "")
                                Text(
                                    "${widget.chapterMember.cells['address']?.value['address']}"),
                            if (widget.chapterMember.cells['address']
                                        ?.value['city'] !=
                                    null ||
                                widget.chapterMember.cells['address']
                                        ?.value['state'] !=
                                    null ||
                                widget.chapterMember.cells['address']
                                        ?.value['zip'] !=
                                    null)
                              Text(
                                  "${widget.chapterMember.cells['address']?.value['city'] != null ? widget.chapterMember.cells['address']?.value['city'] : ""}, ${widget.chapterMember.cells['address']?.value['state'] != null ? widget.chapterMember.cells['address']?.value['state'] : ""} ${widget.chapterMember.cells['address']?.value['zip'] != null && widget.chapterMember.cells['address']?.value['zip'] != "" ? "${widget.chapterMember.cells['address']?.value['zip']}" : ""}"),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${widget.chapterMember.cells['semester']?.value} ${widget.chapterMember.cells['year']?.value} ${widget.chapterMember.cells['lineNumber']?.value != "" ? "#${widget.chapterMember.cells['lineNumber']?.value}" : ""}"),
                        Row(
                          children: [
                            Text(
                              "Crossed On:",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              "${widget.chapterMember.cells['crossingDate']?.value}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (widget.chapterMember.cells['dop']?.value != "")
                      Row(
                        children: [
                          Text(
                            "Dean:",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text("${widget.chapterMember.cells['dop']?.value}",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    if (widget.chapterMember.cells['lineName']?.value != "")
                      Row(
                        children: [
                          Text(
                            "Linename:",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                              "${widget.chapterMember.cells['lineName']?.value}",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    if (widget.chapterMember.cells['nameOfLine']?.value != "")
                      Row(
                        children: [
                          Text(
                            "Name of Line:",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                              "${widget.chapterMember.cells['nameOfLine']?.value}",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    if (widget.chapterMember.cells['dob']?.value != "")
                      Row(
                        children: [
                          Text(
                            "Birthdate:",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text("${widget.chapterMember.cells['dob']?.value}",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        LoadingButton(
                          width: 110,
                          action: (x) async {
                            await client?.createVerification(widget.chapterMember.cells['status']?.value['id'] ?? "");
                            setState(() {});
                            // Navigator.of(context).pop();
                          },
                          text: "Is this You?",
                        ),
                        LoadingButton(
                          width: 110,
                          action: (innerContext) {
                            Navigator.of(context).pop();
                          },
                          text: 'Cancel',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

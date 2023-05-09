import 'package:flutter/material.dart';

import 'package:kookout/layout/full_page_layout.dart';
import 'package:kookout/models/clients/api_client.dart';
import 'package:kookout/models/spreadsheet_member.dart';
import 'package:kookout/shared_components/menus/home_page_menu.dart';
import 'package:kookout/wrappers/app_scaffold_wrapper.dart';
import 'package:kookout/wrappers/hashtag_collection.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/controllers/auth_inherited.dart';
import 'create_post_page.dart';

class ChapterRosterPage extends StatefulWidget {
  const ChapterRosterPage({
    super.key,
  });

  @override
  State<ChapterRosterPage> createState() => _ChapterRosterPageState();
}

class _ChapterRosterPageState extends State<ChapterRosterPage> {
  bool isPanelOpen = false;
  PanelController panelController = PanelController();
  List<SpreadsheetMember> spreadSheetMembers = [];
  late ApiClient client;

  List<String> selectedRows = [];

  @override
  didChangeDependencies() async {
    var theClient = AuthInherited.of(context)?.chatController?.profileClient;
    if (theClient != null) {
      client = theClient;
      spreadSheetMembers = await theClient.fetchChapterRoster() ?? [];
      print(spreadSheetMembers);
    }

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWrapper(
      floatingActionMenu: HomePageMenu(
        updateMenu: () {},
      ),
      child: FullPageLayout(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                48.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingTextStyle: TextStyle(fontSize: 18),
                    columns: [
                      DataColumn(
                          numeric: true,
                          label: Text('ID'),
                          onSort: (colIndex, asc) {
                            print(asc);
                            spreadSheetMembers.sort((l, r) {
                              if (int.parse(l.spreadsheetId!) >
                                  int.parse(r.spreadsheetId!)) {
                                return asc ? 1 : -1;
                              } else if (int.parse(l.spreadsheetId!) <
                                  int.parse(r.spreadsheetId!)) {
                                return asc ? -1 : 1;
                              }
                              return 0;
                            });
                            setState(() {});
                          }),
                      DataColumn(
                        label: Text('Status'),
                      ),
                      DataColumn(
                        label: Text('Chapter'),
                      ),
                      DataColumn(
                        label: Text('Crossed On'),
                      ),
                      DataColumn(
                        label: Text('Semester'),
                      ),
                      DataColumn(
                          label: Text('Year'),
                          onSort: (colIndex, asc) {
                            print(asc);
                            spreadSheetMembers.sort((l, r) {
                              if (int.parse(l.year!) > int.parse(r.year!)) {
                                return asc ? 1 : -1;
                              } else if (int.parse(l.year!) <
                                  int.parse(r.year!)) {
                                return asc ? -1 : 1;
                              }
                              return 0;
                            });
                            setState(() {});
                          }),
                      DataColumn(
                        label: Text('DOP'),
                      ),
                      DataColumn(
                        label: Text('Name of Line'),
                      ),
                      DataColumn(
                        label: Text('Line Name'),
                      ),
                      DataColumn(
                        label: Text('First Name'),
                      ),
                      DataColumn(
                        label: Text('Middle'),
                      ),
                      DataColumn(
                        label: Text('Last Name'),
                      ),
                      DataColumn(
                        label: Text('Nick Name'),
                      ),
                      DataColumn(
                        label: Text('Cellphone'),
                      ),
                      DataColumn(
                        label: Text('Address'),
                      ),
                      DataColumn(
                        label: Text('Email'),
                      ),
                      DataColumn(
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('Homephone'),
                      ),
                      DataColumn(
                        label: Text('Workphone'),
                      ),
                      DataColumn(
                        label: Text('DOB'),
                      ),
                    ],
                    rows: spreadSheetMembers.map((member) {
                      return DataRow(
                        selected: selectedRows.contains(member.spreadsheetId),
                        onSelectChanged: (e) {
                          print(e);
                          if (selectedRows.contains(member.spreadsheetId)) {
                            selectedRows.remove(member.spreadsheetId);
                          } else {
                            selectedRows.add(member.spreadsheetId!);
                          }
                          setState(() {

                          });
                        },
                        cells: [
                          DataCell(
                            Text(int.parse(member.spreadsheetId ?? "")
                                .toString()),
                          ),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (member.isChapterInvisible == true)
                                  Text(
                                    "Chapter Invisible" ?? "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                if (member.isLivesOnCampus == true)
                                  Text(
                                    "Lives on Campus" ?? "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                if (member.isOnTheYard == true)
                                  Text(
                                    "On the yard" ?? "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                if (member.onCampusPosition != null)
                                  Text(
                                    "Campus Position: ${member.onCampusPosition}" ??
                                        "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(member.otherChapterAffiliation ?? ""),
                          ),
                          DataCell(
                            Text(member.crossingDate != null
                                ? member.crossingDate.toString()
                                : ""),
                          ),
                          DataCell(
                            Text(member.semester ?? ""),
                          ),
                          DataCell(
                            Text(member.year ?? ""),
                          ),
                          DataCell(
                            Text(member.dopName ?? ""),
                          ),
                          DataCell(
                            Text(member.nameOfLine ?? ""),
                          ),
                          DataCell(
                            Text(member.lineName ?? ""),
                          ),
                          DataCell(
                            Text(member.firstName ?? ""),
                          ),
                          DataCell(
                            Text(member.middleName ?? ""),
                          ),
                          DataCell(
                            Text(
                                "${member.lastName}${member.title != null && member.title != "" ? ", ${member.title}" : ""}" ??
                                    ""),
                          ),
                          DataCell(
                            Text("${member.nickName}"),
                          ),
                          DataCell(
                            Text(member.cellPhone ?? ""),
                          ),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (member.address != null)
                                  Text(
                                    member.address ?? "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                if (member.city != null)
                                  Text(
                                    "${member.city}${member.state != null ? ", ${member.state}" : ""} ${member.postalCode != null ? member.postalCode : ""}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                          DataCell(
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: member.email?.map((e) {
                                    return Text(
                                      e,
                                      style: TextStyle(fontSize: 12),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                          ),
                          DataCell(
                            Text(member.lineNumber ?? ""),
                          ),
                          DataCell(
                            Text(member.homePhone ?? ""),
                          ),
                          DataCell(
                            Text(member.workPhone ?? ""),
                          ),
                          DataCell(
                            Text(member.dob != null
                                ? member.dob.toString()
                                : ""),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SlidingUpPanel(
              onPanelClosed: () {
                isPanelOpen = false;
              },
              onPanelOpened: () {
                isPanelOpen = true;
              },
              collapsed: MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                color: Colors.red,
                onPressed: () {
                  if (isPanelOpen) {
                    panelController.close();
                    // isPanelOpen = false;
                  } else {
                    panelController.open();
                    // isPanelOpen = true;
                  }
                  setState(() {});
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        8.0,
                        8.0,
                        8.0,
                        16.0,
                      ),
                      child: Container(
                        color: Colors.white,
                        width: 80,
                        height: 3,
                      ),
                    ),
                    const Text(
                      "Upload Photo(s)",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              controller: panelController,
              backdropEnabled: true,
              isDraggable: true,
              parallaxEnabled: false,
              maxHeight: 500,
              color: Colors.transparent,
              minHeight: 64,
              panelBuilder: (scrollController) => SingleChildScrollView(
                // controller: scrollController,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0))),
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      // MaterialButton(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //   ),
                      //   color: Colors.white,
                      //   onPressed: () {
                      //     panelController.close();
                      //   },
                      //   child: Flex(
                      //     direction: Axis.vertical,
                      //     children: [
                      //       Flexible(
                      //         flex: 1,
                      //         child: Padding(
                      //           padding: const EdgeInsets.fromLTRB(
                      //             8.0,
                      //             8.0,
                      //             8.0,
                      //             8.0,
                      //           ),
                      //           child: Container(
                      //             color: Colors.white,
                      //             width: 80,
                      //             height: 3,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               "Create a Post",
                      //               style: TextStyle(color: Colors.black, fontSize: 18),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              child:
                                  Flex(direction: Axis.horizontal, children: [
                                Expanded(
                                  child: MaterialButton(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      panelController.hide();
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            8.0,
                                            8.0,
                                            8.0,
                                            8.0,
                                          ),
                                          child: Container(
                                            color: Colors.black,
                                            width: 80,
                                            height: 3,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Upload Photo(s)",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            CreatePostPage(
                              onPost: () {
                                panelController.close();
                                // _pagingController.firstPageKey
                              },
                              onClose: () {
                                panelController.close();
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

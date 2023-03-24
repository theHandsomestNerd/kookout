import 'package:chat_line/models/comment.dart';
import 'package:chat_line/shared_components/search_box.dart';
import 'package:chat_line/shared_components/timeline_events/timeline_event_solo.dart';
import 'package:flutter/material.dart';

import '../../models/follow.dart';
import '../../models/like.dart';
import '../../models/timeline_event.dart';
import '../comments/comment_solo.dart';
import '../follows/follow_solo.dart';
import '../likes/like_solo.dart';

class TimelineEventThread extends StatelessWidget {
  TimelineEventThread({
    super.key,
    required this.timelineEvents,
  });

  final List<TimelineEvent> timelineEvents;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...timelineEvents != null ?(timelineEvents).map((event) {
          return Column(
            children: [TimelineEventSolo(event: event), Divider()],
          );
        }).toList():[]
      ],
    );
  }
}

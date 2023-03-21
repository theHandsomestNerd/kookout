import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/shared_components/likes_thread.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/like.dart';
import '../../models/timeline_event.dart';
import '../../shared_components/timeline_event_thread.dart';

class TimelineEventsTab extends StatefulWidget {
  const TimelineEventsTab(
      {super.key,
      required this.chatController,
      required this.authController,
      required this.timelineEvents,
      required this.id});

  final AuthController authController;
  final ChatController chatController;
  final String id;
  final List<TimelineEvent>? timelineEvents;

  @override
  State<TimelineEventsTab> createState() => _TimelineEventsTabState();
}

class _TimelineEventsTabState extends State<TimelineEventsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.chatController.updateTimelineEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: TimelineEventThread(
              key: ObjectKey(widget.timelineEvents),
              timelineEvents: widget.timelineEvents ?? [],
            ),
          ),
        ],
      ),
    );
  }

}

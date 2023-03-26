import 'package:chat_line/layout/search_and_list.dart';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import '../../models/controllers/auth_inherited.dart';
import '../../models/timeline_event.dart';
import '../../shared_components/timeline_events/timeline_event_thread.dart';

class TimelineEventsTab extends StatefulWidget {
  const TimelineEventsTab(
      {super.key,
      required this.timelineEvents,
      required this.id});

  final String id;
  final List<TimelineEvent>? timelineEvents;

  @override
  State<TimelineEventsTab> createState() => _TimelineEventsTabState();
}

class _TimelineEventsTabState extends State<TimelineEventsTab> {


  late List<TimelineEvent>? timelineEvents;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timelineEvents = widget.timelineEvents;
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    var theChatController = AuthInherited.of(context)?.chatController;
    timelineEvents = await theChatController?.updateTimelineEvents();
    setState(() {});
    print("timeline events dependencies changed ${timelineEvents}");
  }

  @override
  Widget build(BuildContext context) {
    return SearchAndList(
      listChild: TimelineEventThread(
        key: ObjectKey(timelineEvents),
        timelineEvents: timelineEvents ?? [],
      ),
    );
  }
}

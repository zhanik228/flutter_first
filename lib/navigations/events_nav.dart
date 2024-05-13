import 'package:flutter/material.dart';
import 'package:wsc_flutter_first_try/pages/events_details_page.dart';
import 'package:wsc_flutter_first_try/pages/events_page.dart';

GlobalKey<NavigatorState> eventNavigatorKey = GlobalKey<NavigatorState>();

class EventsNav extends StatelessWidget {
  const EventsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: eventNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
          if (settings.name == '/eventDetails') {
            return EventDetailsPage();
          }

          return EventsPage();
        },);
      },
    );
  }
}
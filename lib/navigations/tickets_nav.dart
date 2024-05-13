import 'package:flutter/material.dart';
import 'package:wsc_flutter_first_try/pages/events_page.dart';
import 'package:wsc_flutter_first_try/pages/tickets_create.dart';
import 'package:wsc_flutter_first_try/pages/tickets_page.dart';

GlobalKey<NavigatorState> ticketNavigatorKey = GlobalKey<NavigatorState>();

class TicketsNav extends StatelessWidget {
  const TicketsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ticketNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          if (settings.name == '/ticketDetails') {
            return Container();
          }

          if (settings.name == '/ticketCreate') {
            return TicketCreatePage();
          }

          return TicketsPage();
        },);
      },
    );
  }
}
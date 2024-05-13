import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsc_flutter_first_try/navigations/events_nav.dart';
import 'package:wsc_flutter_first_try/navigations/tickets_nav.dart';
import 'package:wsc_flutter_first_try/pages/tickets_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    eventNavigatorKey,
    ticketNavigatorKey
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_currentIndex].currentState?.canPop() == true) {
      _navigatorKeys[_currentIndex].currentState?.pop(_navigatorKeys[_currentIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events',),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Tickets',),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Records',),
          ],
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
    );
  }

  final pages = [
    EventsNav(),
    TicketsNav(),
  ];
}
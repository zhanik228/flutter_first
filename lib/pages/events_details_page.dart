import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsc_flutter_first_try/models/event_model.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Events Details'),),
      ),
      body: _prefsInitialized 
      ? Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('${args.eventTitle}'),
            Spacer(),
            Text('view counts ${_prefs.getInt('${args.eventId}_views') ?? 1}'),
            Row(
              children: [
                Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[0]}',
                  width: 100,
                ),
                Spacer(),
                Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[1]}',
                  width: 100,
                ),
                Spacer(),
                Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[2]}',
                  width: 100,
                ),
              ],
            ),
            Spacer(),
            Text('${args.eventText}'),
            Spacer(),
          ],
        ),
      )
            : Center(child: CircularProgressIndicator(),)
    );
  }
}
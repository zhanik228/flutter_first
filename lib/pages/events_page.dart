import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsc_flutter_first_try/models/event_model.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late Future<List<EventModel>> _eventsFuture;
  FilterState _filterState = FilterState.All;
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventsFuture = _readJsonData();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Events List'),),
      ),
      body: Column(
        children: [
          _getFilterBtns(),
          FutureBuilder(
            future: _eventsFuture,
            builder:(context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              if (snapshot.hasData) {
                List<EventModel> data = snapshot.data as List<EventModel>;
                _loadReadStatus(data);
                List<EventModel> filteredData = _filterEvents(data);
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Column(
                            children: [
                              Text('${filteredData[index].eventTitle}'),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  '${filteredData[index].eventText}',
                                  overflow: TextOverflow.ellipsis,),
                              ),
                              Text(
                                '${filteredData[index].eventReadStatus == true ? 'Read' : 'Unread'}'
                              )
                          ],),
                          onTap: () {
                            _markAsRead(filteredData[index]);
                            incrementViews(filteredData[index]);
                            Navigator.pushNamed(context, '/eventDetails', arguments: filteredData[index]);
                          },
                          leading: Image.asset(
                            'assets/events_resources/images/${filteredData[index].eventPictures?[0]}',
                            width: 128,
                            fit: BoxFit.cover,),
                        ),
                      );
                    }
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }

  Future<List<EventModel>> _readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/events_resources/json/events_data.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => EventModel.fromJson(e)).toList();
  }

  Widget _getFilterBtns() {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            _updateFilterState(FilterState.All);
          }, 
          child: Text('All'),
        ),
        Text('/'),
        TextButton(
          onPressed: () {
            _updateFilterState(FilterState.Unread);
          }, 
          child: Text('Unread'),
        ),
        Text('/'),
        TextButton(
          onPressed: () {
            _updateFilterState(FilterState.Read);
          }, 
          child: Text('Read'),
        ),
      ],
    );
  }

  List<EventModel> _filterEvents(List<EventModel> events) {
    switch (_filterState) {
      case FilterState.All:
        return events;
      case FilterState.Read:
        return events.where((event) => event.eventReadStatus == true).toList();
      case FilterState.Unread:
        return events.where((event) => event.eventReadStatus != true).toList();
    }
  }

  void _updateFilterState(FilterState filterState) {
    setState(() {
      _filterState = filterState;
    });
  }

  bool _isEventRead(EventModel event) {
    return _prefs.getBool('${event.eventId}_read') ?? false;
  }

  void _markAsRead(EventModel event) {
    event.eventReadStatus = true;
    setState(() {
      _filterState = FilterState.All;
    });
    _prefs.setBool('${event.eventId}_read', true);
  }

  void incrementViews(EventModel event) {
    var prevCount = _prefs.getInt('${event.eventId}_views') ?? 0;
    _prefs.setInt('${event.eventId}_views', prevCount+1);
  }

  void _loadReadStatus(List<EventModel> events) {
    for (var event in events) {
      event.eventReadStatus = _isEventRead(event);
    }
  }
}

enum FilterState {
  All,
  Read,
  Unread,
}
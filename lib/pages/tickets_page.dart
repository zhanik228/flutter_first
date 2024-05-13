import 'package:flutter/material.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tickets List'),),
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/ticketCreate');
        },
        child: Text('Create a new ticket'),
      ),
    );
  }
}
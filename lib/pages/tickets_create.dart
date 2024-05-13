import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TicketCreatePage extends StatefulWidget {
  const TicketCreatePage({super.key});

  @override
  State<TicketCreatePage> createState() => _TicketCreatePageState();
}

class _TicketCreatePageState extends State<TicketCreatePage> {
  String dropdownValue = 'closing';
  final _textController = TextEditingController();
  File ? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Ticket Create'),),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'closing',
                  child: Text('Closing Ceremony'),
                ),
                DropdownMenuItem<String>(
                  value: 'opening',
                  child: Text('Opening Ceremony'),
                ),
              ],
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Input your name',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery();
              }, child: Text('Choose one picture')),
            _selectedImage != null ? Image.file(_selectedImage!) : Text('Please select an image')
          ]
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}
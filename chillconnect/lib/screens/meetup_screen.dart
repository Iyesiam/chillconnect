// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';

class MeetupScreen extends StatefulWidget {
  @override
  _MeetupScreenState createState() => _MeetupScreenState();
}

class _MeetupScreenState extends State<MeetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _meetupTitle = '';
  String _meetupDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Meetup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Meetup Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _meetupTitle = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Meetup Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _meetupDescription = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // You can add code here to send the meetup details to the backend or save it locally
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Meetup Created')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

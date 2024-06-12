import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chillconnect/screens/chat.dart';

class Comment {
  final String text;
  final String author;
  final String date;
  final String profilePicUrl;

  Comment({
    required this.text,
    required this.author,
    required this.date,
    required this.profilePicUrl,
  });
}

class MeetupDetailsPage extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final List<String> attendees;

  MeetupDetailsPage({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
  });

  @override
  _MeetupDetailsPageState createState() => _MeetupDetailsPageState();
}

class _MeetupDetailsPageState extends State<MeetupDetailsPage> {
  bool hasJoined = false;
  List<Comment> comments = [];
  final TextEditingController _commentController = TextEditingController();

  void joinMeetup() {
    setState(() {
      widget.attendees.add('Current User'); // Add the current user to the attendees list
      hasJoined = true;
    });
  }

  void openChatroom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatroomPage(comments: comments),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetup Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text('Meetup Title'),
                    subtitle: Text(widget.title),
                  ),
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(widget.date),
                  ),
                  ListTile(
                    title: Text('Time'),
                    subtitle: Text(widget.time),
                  ),
                  ListTile(
                    title: Text('Location'),
                    subtitle: Text(widget.location),
                  ),
                  ListTile(
                    title: Text('Description'),
                    subtitle: Text(widget.description),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Attendees (${widget.attendees.length})',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.attendees.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.attendees[index]),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: hasJoined ? null : joinMeetup, // Disable the button if already joined
                          child: Text('Join'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: hasJoined ? openChatroom : null, // Enable only if joined
                            child: Text('Open Chatroom'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the ExploreScreen and show the location
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExploreScreen(
                                  initialLocation: widget.location,
                                ),
                              ),
                            );
                          },
                          child: Text('View on Map'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  final String initialLocation;

  ExploreScreen({required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    // Parse the location to extract latitude and longitude
    final coordinates = initialLocation.split(',');
    final latitude = double.parse(coordinates[0]);
    final longitude = double.parse(coordinates[1]);

    return Scaffold(
      appBar: AppBar(title: Text('Explore')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              var _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: MarkerId('meetupLocation'),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(
                  title: 'Meetup Location',
                  snippet: 'This is where the meetup is happening!',
                ),
              ),
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Here's",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'where It is Happening',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

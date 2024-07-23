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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDetailTile('Meetup Title', widget.title),
            _buildDetailTile('Date', widget.date),
            _buildDetailTile('Time', widget.time),
            _buildDetailTile('Location', widget.location),
            _buildDetailTile('Description', widget.description),
            SizedBox(height: 20),
            Text(
              'Attendees (${widget.attendees.length})',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildAttendeesList(),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildAttendeesList() {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: widget.attendees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.attendees[index]),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: hasJoined ? null : joinMeetup,
            child: Text('Join'),
            style: ElevatedButton.styleFrom(
              primary: hasJoined ? Colors.grey : Colors.blue,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: hasJoined ? openChatroom : null,
            child: Text('Open Chatroom'),
            style: ElevatedButton.styleFrom(
              primary: hasJoined ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
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
        ),
      ],
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
      body: GoogleMap(
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
    );
  }
}

import 'package:flutter/material.dart';

class MeetupDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetup Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Feature 1: Event Details
            Text(
              'Event Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Add detailed information about the meetup here
            ListTile(
              title: Text('Meetup Title'),
              subtitle: Text('Title of the meetup event'),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text('Date of the meetup event'),
            ),
            ListTile(
              title: Text('Time'),
              subtitle: Text('Time of the meetup event'),
            ),
            // Add more details as needed

            // Feature 2: Attendee List
            SizedBox(height: 20),
            Text(
              'Attendee List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display a list of attendees who have RSVP'd for the meetup

            // Feature 3: RSVP Functionality
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement RSVP functionality
              },
              child: Text('RSVP'),
            ),

            // Feature 4: Map Integration
            SizedBox(height: 20),
            Text(
              'Meetup Location',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display a map with the meetup location pinned

            // Feature 5: Discussion Section
            SizedBox(height: 20),
            Text(
              'Discussion Section',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Provide a section for attendees to discuss the meetup

            // Feature 6: Organizer Information
            SizedBox(height: 20),
            Text(
              'Organizer Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Include information about the meetup organizer

            // Feature 7: Related Meetups
            SizedBox(height: 20),
            Text(
              'Related Meetups',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Show related meetups or events that users might be interested in

            // Feature 8: Social Sharing
            SizedBox(height: 20),
            Text(
              'Social Sharing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Allow users to share the meetup details on social media platforms

            // Feature 9: Event Reminders
            SizedBox(height: 20),
            Text(
              'Event Reminders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Provide an option for users to set reminders for the meetup

            // Feature 10: Feedback and Rating
            SizedBox(height: 20),
            Text(
              'Feedback and Rating',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Allow users to provide feedback and rate their experience after the meetup
          ],
        ),
      ),
    );
  }
}

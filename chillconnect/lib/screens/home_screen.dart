// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(preferences.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Handle search button press
            },
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
            // Replace with user's profile image
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hey, Naina 👋',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Connect With Others',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              SizedBox(height: 24),
              Text(
                'November 2022',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildWeekdayChips(),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Our Favorites 🔥',
                style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(preferences.length, (index) {
                  return PreferenceChip(
                    label: preferences[index],
                    onPressed: () {
                      setState(() {
                        selected[index] = !selected[index];
                      });
                    },
                    isSelected: selected[index],
                  );
                }),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/25448.png', // Image path
                height: 200,
                width: double.infinity,
              ),
              Padding(
  padding: const EdgeInsets.all(8.0),
  child: Center(
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/meetup');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 78, 85, 85), // Background color
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'Create a Meetup',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Text color
      ),
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeekdayChips() {
    List<Widget> weekdayChips = [];

    DateTime currentDate = DateTime.now();
    DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));

    // Loop through the weekdays and generate the date chips
    for (int i = 0; i < 7; i++) {
      DateTime date = startOfWeek.add(Duration(days: i));
      String formattedDate = DateFormat('dd MMM').format(date);
      String formattedDay = DateFormat('EEE').format(date);

      weekdayChips.add(_buildDateChip(formattedDate, formattedDay, i == 0));
    }

    return weekdayChips;
  }

  Widget _buildDateChip(String date, String day, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        backgroundColor: isSelected ? Colors.blue : Color.fromARGB(255, 53, 54, 54),
        label: Column(
          children: [
            Text(
              date,
              style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold),
            ),
            Text(
              day,
              style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  List<String> preferences = [
    'Music',
    'Books',
    'Coding',
    'Poems',
    'Drawing',
    'Photography',
    'Swimming',
    'Surfing',
  ];
}

class PreferenceChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const PreferenceChip({
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Color.fromARGB(255, 49, 50, 50),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

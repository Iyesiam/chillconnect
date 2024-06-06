import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('ChillConnect'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome to ChillConnect!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          // Preferences chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
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
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/meetup');
              },
              child: Text('Create a Meetup'),
            ),
          ),
        ],
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
    // Add more preferences here
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
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

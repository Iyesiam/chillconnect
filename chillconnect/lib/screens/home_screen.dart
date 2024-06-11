import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<bool> selected;
  int _selectedIndex = 0;
  List<int> selectedDays = []; // List of selected days
  List<String> selectedPreferences = [];
  bool isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    selected = List.generate(preferences.length, (index) => false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          // Already on HomeScreen, no navigation needed
          break;
        case 1:
          Navigator.pushNamed(context, '/meetup');
          break;
        case 2:
          Navigator.pushNamed(context, '/explore');
          break;
      }
    });
  }

  List<Map<String, dynamic>> _getRecommendedMeetups() {
    List<Map<String, dynamic>> meetups = [
      {
        'title': 'Book Club',
        'description': 'Discussing the latest in literature.',
        'day': 2,
        'preferences': ['Books'],
      },
      {
        'title': 'Music Jam',
        'description': 'Jamming to new and classic tunes.',
        'day': 4,
        'preferences': ['Music'],
      },
      // Add more meetups as needed
    ];

    // Filter meetups based on selected days and preferences
    return meetups.where((meetup) {
      bool dayMatches = selectedDays.isEmpty || selectedDays.contains(meetup['day']);
      bool preferenceMatches = selectedPreferences.isEmpty ||
          meetup['preferences'].any((preference) => selectedPreferences.contains(preference));
      bool searchMatches = searchQuery.isEmpty || 
          meetup['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          meetup['description'].toLowerCase().contains(searchQuery.toLowerCase());
      return dayMatches && preferenceMatches && searchMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isSearching ? Icons.arrow_back : Icons.menu, color: Colors.white),
          onPressed: () {
            setState(() {
              if (isSearching) {
                isSearching = false;
                searchQuery = "";
              } else {
                // Handle menu button press
              }
            });
          },
        ),
        title: isSearching
            ? TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search meetups...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              )
            : Text(
                "Home",
                style: TextStyle(color: Colors.white), // Set the text color to white
              ),
        actions: [
          if (!isSearching)
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
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
                DateFormat('dd MMM yyyy').format(currentDate),
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
                'Your Favorites 🔥',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
                        if (selected[index]) {
                          selectedPreferences.add(preferences[index]);
                        } else {
                          selectedPreferences.remove(preferences[index]);
                        }
                      });
                    },
                    isSelected: selected[index],
                  );
                }),
              ),
              SizedBox(height: 24),
              Text(
                'Recommended Meetups',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getRecommendedMeetups().map((meetup) {
                    return Container(
                      margin: EdgeInsets.only(right: 16.0),
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meetup['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            meetup['description']!,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[900],
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(Icons.home, color: Colors.white, size: 30),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(Icons.add_box_outlined, color: Colors.white, size: 30),
                ),
                label: 'Meetup',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(Icons.explore, color: Colors.white, size: 30),
                ),
                label: 'Explore',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 244, 246, 248),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeekdayChips() {
    List<Widget> weekdayChips = [];

    DateTime currentDate = DateTime.now();
    DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));

    for (int i = 0; i < 7; i++) {
      DateTime date = startOfWeek.add(Duration(days: i));
      String formattedDate = DateFormat('dd MMM').format(date);
      String formattedDay = DateFormat('EEE').format(date);

      weekdayChips.add(_buildDateChip(formattedDate, formattedDay, selectedDays.contains(i), i));
    }

    return weekdayChips;
  }

  Widget _buildDateChip(String date, String day, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              selectedDays.remove(index);
            } else {
              selectedDays.add(index);
            }
          });
        },
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
      ),
    );
  }

  List<String> preferences = [
    'Music', 'Books', 'Coding', 'Poems',
    'Drawing', 'Photography', 'Swimming', 'Surfing',
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

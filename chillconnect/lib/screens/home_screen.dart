import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chillconnect/screens/meetupdetailspage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late List<bool> selected;
  int _selectedIndex = 0;
  List<int> selectedDays = [];
  List<String> selectedPreferences = [];
  bool isSearching = false;
  String searchQuery = "";

  final List<String> preferences = [
    'Books',
    'Music',
    'Technology',
    'Art',
    'Sports',
    'Travel',
    'Food',
    'Health',
    'Fashion',
    'Business',
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    selected = List.generate(preferences.length, (index) => false);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
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
        'day': 5,
        'preferences': ['Books'],
        'date': '10 Jun 2024',
        'time': '5:00 PM',
      },
      {
        'title': 'Music Jam',
        'description': 'Jamming to new and classic tunes.',
        'day': 6,
        'preferences': ['Music'],
        'date': '12 Jun 2024',
        'time': '6:00 PM',
      },
    ];

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

  List<Widget> _buildWeekdayChips() {
    final List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return List<Widget>.generate(7, (index) {
      final isSelected = selectedDays.contains(index);
      return ChoiceChip(
        label: Text(weekdays[index]),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              selectedDays.add(index);
            } else {
              selectedDays.remove(index);
            }
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    // Start animations
    if (isSearching) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

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
            ? FadeTransition(
          opacity: _fadeAnimation,
          child: TextField(
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
          ),
        )
            : Text(
          "Home",
          style: TextStyle(color: Colors.white),
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
                'Hey, Natasha 👋',
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
              SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _getRecommendedMeetups().map((meetup) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeetupDetailsPage(
                                title: meetup['title'],
                                description: meetup['description'],
                                date: meetup['date'],
                                time: meetup['time'],
                                location: 'Example Location',
                                attendees: ['Attendee 1', 'Attendee 2'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  meetup['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  meetup['description'],
                                  style: TextStyle(fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 14, 14, 14), Color.fromARGB(255, 14, 14, 14)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              items: [
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
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              onTap: _onItemTapped,
              elevation: 5,
            ),
          ),
        ),
      ),
    );
  }
}

class PreferenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  PreferenceChip({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          onPressed();
        },
        selectedColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Color.fromARGB(179, 253, 250, 250),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

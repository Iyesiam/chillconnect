import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetupScreen extends StatefulWidget {
  @override
  _MeetupScreenState createState() => _MeetupScreenState();
}

class _MeetupScreenState extends State<MeetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String _meetupTitle = '';
  String _meetupDescription = '';
  String _meetupLocation = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedIndex = 1;
  List<Map<String, String>> _meetups = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
        // Already on MeetupScreen, no navigation needed
          break;
        case 2:
          Navigator.pushNamed(context, '/explore');
          break;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitMeetup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _meetups.add({
          'title': _meetupTitle,
          'description': _meetupDescription,
          'location': _meetupLocation,
          'date': _selectedDate != null ? DateFormat('dd MMM yyyy').format(_selectedDate!) : '',
          'time': _selectedTime != null ? _selectedTime!.format(context) : ''
        });
        _titleController.clear();
        _descriptionController.clear();
        _locationController.clear();
        _selectedDate = null;
        _selectedTime = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meetup Created')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 254, 253, 253),
        elevation: 0,
        title: Text(
          'Create a Meetup',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _meetups.isNotEmpty
                ? SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _meetups.map((meetup) {
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
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            meetup['description']!,
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Location: ${meetup['location']}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Date: ${meetup['date']}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Time: ${meetup['time']}',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
                : Container(),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Meetup Title',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Color.fromARGB(255, 26, 26, 26),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Meetup Description',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color.fromARGB(255, 22, 22, 22),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _meetupDescription = value!;
                    },
                    maxLines: 5,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _locationController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Meetup Location',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color.fromARGB(255, 22, 22, 22),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      prefixIcon: Icon(Icons.location_on, color: Colors.white70),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _meetupLocation = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 26, 26, 26),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : DateFormat('dd MMM yyyy').format(_selectedDate!),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectTime(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 26, 26, 26),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            _selectedTime == null
                                ? 'Select Time'
                                : _selectedTime!.format(context),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitMeetup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1D68E3),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      ),
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

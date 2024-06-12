// main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/meetup_screen.dart';
import 'screens/explore_screen.dart'; // Add this import
import 'screens/SignUpScreen.dart';
void main() {
  runApp(ChillConnectApp());
}

class ChillConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChillConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/meetup': (context) => MeetupScreen(),
        '/explore': (context) => MapScreen(),
        '/signup': (context) => SignUpScreen(), // Add this route
      },
    );
  }
}
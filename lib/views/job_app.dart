import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_tabs_screen.dart';
import 'landing_screen.dart';

class JobApp extends StatefulWidget {
  const JobApp({super.key});

  @override
  State<JobApp> createState() => _JobAppState();
}

class _JobAppState extends State<JobApp> {
  bool _hasSeenIntro = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfSeenIntro();
  }

  Future<void> _checkIfSeenIntro() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool('hasSeenIntro') ?? false;

    setState(() {
      _hasSeenIntro = hasSeen;
      _isLoading = false;
    });

    // Mark as seen after showing landing screen
    if (!hasSeen) {
      await prefs.setBool('hasSeenIntro', true);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    // Always show landing screen
    return const LandingScreen();
  }
}
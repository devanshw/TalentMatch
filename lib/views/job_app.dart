import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_tabs_screen.dart';

class JobApp extends StatefulWidget {
  const JobApp({super.key});

  @override
  State<JobApp> createState() => _JobAppState();
}

class _JobAppState extends State<JobApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroPopup();
    });
  }

  Future<void> _showIntroPopup() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = false;

    if (hasSeen || !mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Welcome to TalentMatch!"),
        content: const Text(
          "• Upload your resume\n"
          "• Explore job listings\n"
          "--> Swipe right to favorite\n"
          "<-- Swipe left to dislike\n\n"
          "TalentMatch ranks jobs based on your resume."
        ),
        actions: [
          TextButton(
            child: const Text("Got it"),
            onPressed: () async {
              await prefs.setBool('hasSeenIntro', true);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HomeTabsScreen(); // <-- no MaterialApp here
  }
}

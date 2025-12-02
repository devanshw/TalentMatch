import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_match/l10n/app_localizations.dart';
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

    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.welcomeTitle),
        content: Text(l10n.welcomeMessage),
        actions: [
          TextButton(
            child: Text(l10n.gotIt),
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
    return const HomeTabsScreen();
  }
}
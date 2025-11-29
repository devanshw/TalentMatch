import 'package:flutter/material.dart';
import 'job_search_screen.dart';
import 'accepted_jobs_screen.dart';
import 'rejected_jobs_screen.dart';
import 'applied_jobs_screen.dart'; // ⬅️ NEW SCREEN

class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,       // ⬅️ was 3, now 4 tabs
      initialIndex: 1, // Explore stays centered
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TalentMatch"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.block), text: "Rejected"),
              Tab(icon: Icon(Icons.search), text: "Explore"),
              Tab(icon: Icon(Icons.favorite), text: "Favorites"),
              Tab(icon: Icon(Icons.check_circle), text: "Applied"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RejectedJobsScreen(),
            JobSearchScreen(),
            AcceptedJobsScreen(),
            AppliedJobsScreen(),
          ],
        ),
      ),
    );
  }
}

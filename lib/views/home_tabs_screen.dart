import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'job_search_screen.dart';
import 'accepted_jobs_screen.dart';
import 'rejected_jobs_screen.dart';
import 'applied_jobs_screen.dart';

class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1, // Explore stays centered
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.work_outline, size: 24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text("TalentMatch"),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                tabs: [
                  Tab(icon: Icon(Icons.thumb_down, size: 22), text: "Dislike"),
                  Tab(icon: Icon(Icons.explore, size: 22), text: "Explore"),
                  Tab(icon: Icon(Icons.favorite, size: 22), text: "Favorites"),
                  Tab(icon: Icon(Icons.check_circle, size: 22), text: "Applied"),
                ],
              ),
            ),
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
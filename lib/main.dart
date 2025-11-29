import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/job_view_model.dart';
import 'views/home_tabs_screen.dart';
import 'services/job_api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JobViewModel(apiService: JobApiService()),
        ),
      ],
      child: const JobApp(),
    ),
  );
}

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTabsScreen(),
    );
  }
}

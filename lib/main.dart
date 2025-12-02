import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/job_view_model.dart';
import 'services/job_api_service.dart';
import 'views/job_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JobViewModel(apiService: JobApiService()),
        ),
      ],
      child: const MyRootApp(),
    ),
  );
}

class MyRootApp extends StatelessWidget {
  const MyRootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobApp(),
    );
  }
}

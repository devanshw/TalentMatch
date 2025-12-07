// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:talent_match/l10n/app_localizations.dart';

import 'package:talent_match/models/job.dart';
import 'package:talent_match/services/job_api_service.dart';
import 'package:talent_match/viewmodels/job_view_model.dart';
import 'package:talent_match/views/job_details_screen.dart';
import 'package:talent_match/widgets/job_card.dart';
import 'package:talent_match/widgets/job_list.dart';

void main() {
  testWidgets('JobCard shows correct first and second button labels',
    (WidgetTester tester) async {
  // Create a fake job
  final job = Job(
    id: '1',
    title: 'Software Engineer',
    employer: 'Tech Corp',
    description: ""
  );

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: JobCard(
          job: job,
          onTap: () {},
          firstButtonLabel: "Apply",
          firstButtonCallback: () {},
          secondButtonLabel: "Dislike",
          secondButtonCallback: () {},
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();

  // Verify both button labels appear
  expect(find.text("Apply"), findsOneWidget);
  expect(find.text("Dislike"), findsOneWidget);
});

testWidgets('JobList shows no jobs message when empty', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: JobList(
            jobs: [],
            onTap: (_) {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify the no jobs text is shown
    expect(find.text('No jobs found'), findsOneWidget);
  });

  testWidgets('JobDetailsScreen shows job info and toggles description', (tester) async {
    // Sample job with long description
    final job = Job(
      id: "",
      title: 'Software Engineer',
      employer: 'Tech Corp',
      description: 'A' * 300, // 300 characters
      relevance: 85,
      logo: null,
      applyLink: null,
      hasApplied: false,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<JobViewModel>(
        create: (_) => JobViewModel(apiService: JobApiService()),
        child: MaterialApp(
          home: JobDetailsScreen(job: job),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify job title and employer
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Tech Corp'), findsOneWidget);

    // Short description is visible (truncated)
    expect(find.textContaining('...'), findsOneWidget);

    // "Show More" button exists
    final showMoreButton = find.text('Show More');
    expect(showMoreButton, findsOneWidget);

    // Tap "Show More"
    await tester.tap(showMoreButton);
    await tester.pumpAndSettle();

    // Full description is now visible
    expect(find.textContaining('A' * 300), findsOneWidget);
  });

  test('acceptJob moves job from jobs to acceptedJobs', () {
    JobViewModel viewModel = JobViewModel(apiService: JobApiService());
    final job = Job(id: '1', title: 'Dev', employer: 'Company', description: '');
    viewModel.jobs = [job];

    viewModel.acceptJob(job);

    expect(viewModel.acceptedJobs, contains(job));
    expect(viewModel.jobs, isEmpty);
  });
}

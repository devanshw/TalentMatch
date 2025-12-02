// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TalentMatch';

  @override
  String get dislike => 'Dislike';

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Favorites';

  @override
  String get applied => 'Applied';

  @override
  String get welcomeTitle => 'Welcome to TalentMatch!';

  @override
  String get welcomeMessage =>
      '• Upload your resume\n• Explore job listings\n--> Swipe right to favorite\n<-- Swipe left to dislike\n\nTalentMatch ranks jobs based on your resume.';

  @override
  String get gotIt => 'Got it';

  @override
  String get searchJobs => 'Search jobs...';

  @override
  String get uploadResume => 'Upload Resume';

  @override
  String get resumeUploaded => 'Resume uploaded successfully!';

  @override
  String get noJobsFound => 'No jobs found';

  @override
  String relevance(int percent) {
    return 'Relevance: $percent%';
  }

  @override
  String get apply => 'Apply';

  @override
  String get markApplied => 'Mark Applied';

  @override
  String get appliedStatus => 'Applied';

  @override
  String get unapply => 'Unapply';

  @override
  String get delete => 'Delete';

  @override
  String get favorite => 'Favorite';

  @override
  String get showMore => 'Show More 🔽';

  @override
  String get showLess => 'Show Less';

  @override
  String get button => 'Button';
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_match/l10n/app_localizations.dart';
import '../main.dart';
import 'job_search_screen.dart';
import 'accepted_jobs_screen.dart';
import 'rejected_jobs_screen.dart';
import 'applied_jobs_screen.dart';

class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);

    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          // Center logo and title
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo image
              Image.asset(
                'lib/assets/images/logo.png',
                width: 36,
                height: 36,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.work_outline,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text(l10n.appTitle),
            ],
          ),
          actions: [
            PopupMenuButton<Locale>(
              icon: const Icon(Icons.language),
              onSelected: (Locale locale) {
                localeProvider.setLocale(locale);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
                const PopupMenuItem<Locale>(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                const PopupMenuItem<Locale>(
                  value: Locale('es'),
                  child: Text('Español'),
                ),
                const PopupMenuItem<Locale>(
                  value: Locale('fr'),
                  child: Text('Français'),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: const Icon(Icons.thumb_down), text: l10n.dislike),
              Tab(icon: const Icon(Icons.search), text: l10n.explore),
              Tab(icon: const Icon(Icons.favorite), text: l10n.favorites),
              Tab(icon: const Icon(Icons.check_circle), text: l10n.applied),
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

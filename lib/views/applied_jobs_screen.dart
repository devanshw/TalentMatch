import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_match/l10n/app_localizations.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'job_details_screen.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  void _openApplyLink(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);
    final l10n = AppLocalizations.of(context)!;

    return JobList(
      jobs: viewModel.appliedJobs,
      onTap: (job) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobDetailsScreen(job: job),
        ),
      ),
      firstButtonCallback: (job) => _openApplyLink(job.applyLink),
      firstButtonLabel: l10n.apply,
      firstButtonIcon: Icons.launch,
      firstButtonColor: Colors.blue,
      secondButtonCallback: (job) => viewModel.unmarkApplied(job),
      secondButtonLabel: l10n.unapply,
      secondButtonIcon: Icons.undo,
      secondButtonColor: Colors.orange,
    );
  }
}
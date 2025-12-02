import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_match/l10n/app_localizations.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_list.dart';
import 'job_details_screen.dart';

class RejectedJobsScreen extends StatelessWidget {
  const RejectedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);
    final l10n = AppLocalizations.of(context)!;

    return JobList(
      jobs: viewModel.rejectedJobs,
      onTap: (job) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobDetailsScreen(job: job),
        ),
      ),
      firstButtonCallback: (job) => viewModel.moveToAccepted(job),
      firstButtonLabel: l10n.favorite,
      firstButtonIcon: Icons.favorite,
      firstButtonColor: Colors.lightGreen,
      secondButtonCallback: (job) => viewModel.deleteRejected(job),
      secondButtonLabel: l10n.delete,
      secondButtonIcon: Icons.delete,
      secondButtonColor: Colors.red,
    );
  }
}
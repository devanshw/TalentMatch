// lib/views/applied_jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    return JobList(
      jobs: viewModel.appliedJobs,         // ⬅️ from JobViewModel
      onTap: (job) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobDetailsScreen(job: job),
        ),
      ),
      firstButtonCallback: (job) => _openApplyLink(job.applyLink),
      firstButtonLabel: "Apply",
      firstButtonIcon: Icons.launch,
      firstButtonColor: Colors.blue,

      secondButtonCallback: (job) => viewModel.unmarkApplied(job),
      secondButtonLabel: "Unapply",
      secondButtonIcon: Icons.undo,
      secondButtonColor: Colors.orange,
    );
  }
}

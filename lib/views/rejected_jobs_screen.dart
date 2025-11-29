// lib/views/rejected_jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_list.dart';
import 'job_details_screen.dart';

class RejectedJobsScreen extends StatelessWidget {
  const RejectedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);

    return JobList(
      jobs: viewModel.rejectedJobs,
      onTap: (job) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobDetailsScreen(job: job),
        ),
      ),
      firstButtonCallback: (job) => viewModel.moveToAccepted(job),
      firstButtonLabel: "Favorite",
      firstButtonIcon: Icons.favorite,
      firstButtonColor: Colors.lightGreen,
      secondButtonCallback: (job) => viewModel.deleteRejected(job),
      secondButtonLabel: "Delete",
      secondButtonIcon: Icons.delete,
      secondButtonColor: Colors.red,
    );
  }
}

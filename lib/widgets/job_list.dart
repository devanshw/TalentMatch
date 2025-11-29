// lib/widgets/job_list.dart
import 'package:flutter/material.dart';
import '../models/job.dart';
import 'job_card.dart';

class JobList extends StatelessWidget {
  final List<Job> jobs;
  final void Function(Job) onTap;
  final void Function(Job)? firstButtonCallback;
  final String? firstButtonLabel;
  final IconData? firstButtonIcon;
  final Color? firstButtonColor;
  final void Function(Job)? secondButtonCallback;
  final String? secondButtonLabel;
  final IconData? secondButtonIcon;
  final Color? secondButtonColor;

  const JobList({
    super.key,
    required this.jobs,
    required this.onTap,
    this.firstButtonCallback,
    this.firstButtonLabel,
    this.firstButtonIcon,
    this.firstButtonColor,
    this.secondButtonCallback,
    this.secondButtonLabel,
    this.secondButtonIcon,
    this.secondButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return const Center(child: Text("No jobs found"));

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];

        return JobCard(
          job: job,
          onTap: () => onTap(job),
          firstButtonCallback:
              firstButtonCallback != null ? () => firstButtonCallback!(job) : null,
          firstButtonLabel: firstButtonLabel,
          firstButtonIcon: firstButtonIcon,
          firstButtonColor: firstButtonColor,
          secondButtonCallback:
              secondButtonCallback != null ? () => secondButtonCallback!(job) : null,
          secondButtonLabel: secondButtonLabel,
          secondButtonIcon: secondButtonIcon,
          secondButtonColor: secondButtonColor,
        );
      },
    );
  }
}

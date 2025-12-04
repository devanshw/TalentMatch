import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job.dart';
import '../viewmodels/job_view_model.dart';
import '../theme/app_theme.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool showMore = false;

  void _applyToJob(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final viewModel = Provider.of<JobViewModel>(context);

    final full = job.description;
    final short =
        full.length > 200 ? full.substring(0, 200).trimRight() + '...' : full;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: const Text("Job Details"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Gradient
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: Column(
                  children: [
                    // Logo
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: job.logo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                job.logo!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.work,
                                        color: AppTheme.primaryBlue, size: 45),
                              ),
                            )
                          : const Icon(Icons.work,
                              color: AppTheme.primaryBlue, size: 45),
                    ),

                    const SizedBox(height: 20),

                    // Job Title
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Employer
                    Text(
                      job.employer,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Relevance Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppTheme.chipRadius,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              color: AppTheme.primaryBlue, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "${job.relevance}% Match",
                            style: const TextStyle(
                              color: AppTheme.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Job Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadius,
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showMore ? full : short,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppTheme.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        if (full.length > 200)
                          Center(
                            child: TextButton(
                              onPressed: () =>
                                  setState(() => showMore = !showMore),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    showMore ? "Show Less" : "Show More",
                                    style: const TextStyle(
                                      color: AppTheme.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    showMore
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      // APPLY BUTTON
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppTheme.buttonRadius,
                            boxShadow: AppTheme.buttonShadow,
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.launch),
                            label: const Text("Apply Now"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppTheme.buttonRadius,
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => _applyToJob(job.applyLink),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // MARK APPLIED BUTTON (TOGGLE)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppTheme.buttonRadius,
                            boxShadow: [
                              BoxShadow(
                                color: (job.hasApplied
                                        ? AppTheme.successGreen
                                        : Colors.grey)
                                    .withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            icon: Icon(
                              job.hasApplied
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                            ),
                            label: Text(
                                job.hasApplied ? "Applied" : "Mark Applied"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: job.hasApplied
                                  ? AppTheme.successGreen
                                  : Colors.grey[300],
                              foregroundColor: job.hasApplied
                                  ? Colors.white
                                  : AppTheme.textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppTheme.buttonRadius,
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => viewModel.toggleApplied(job),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
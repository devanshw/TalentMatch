import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job.dart';
import '../viewmodels/job_view_model.dart';

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
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (job.logo != null)
                Center(child: Image.network(job.logo!, height: 80)),

              const SizedBox(height: 10),
              Text(
                job.employer,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),
              Text(
                "Relevance: ${job.relevance}%",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),
              Text(showMore ? full : short, style: const TextStyle(fontSize: 16)),

              if (full.length > 200)
                TextButton(
                  onPressed: () => setState(() => showMore = !showMore),
                  child: Text(showMore ? "Show Less" : "Show More 🔽"),
                ),

              const SizedBox(height: 20),

              Row(
                children: [
                  // APPLY BUTTON
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.launch),
                      label: const Text("Apply"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => _applyToJob(job.applyLink),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // MARK APPLIED BUTTON (TOGGLE)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        job.hasApplied
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                      ),
                      label: Text(job.hasApplied ? "Applied" : "Mark Applied"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            job.hasApplied ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => viewModel.toggleApplied(job),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

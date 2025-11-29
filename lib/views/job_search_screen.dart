// lib/views/job_search_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/job.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_card.dart';
import '../services/resume_parser.dart';
import 'job_details_screen.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context); // listen: true
    final TextEditingController _searchController = TextEditingController();

    return Column(
      children: [
        // Search bar + resume upload
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Search jobs...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      viewModel.searchJobs(query);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.upload_file, size: 28),
                tooltip: "Upload Resume",
                onPressed: () async {
                  final resumeText = await parseResumeFile();
                  if (resumeText != null) {
                    await viewModel.uploadResume(resumeText);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Resume uploaded successfully!")),
                    );
                  }
                },
              ),
            ],
          ),
        ),

        // Job list with swipe gestures
        Expanded(
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.jobs.isEmpty
                  ? const Center(child: Text("No jobs found"))
                  : ListView.builder(
                      itemCount: viewModel.jobs.length,
                      itemBuilder: (context, index) {
                        final job = viewModel.jobs[index];

                        return JobCardWrapper(job: job);
                      },
                    ),
        ),
      ],
    );
  }
}

class JobCardWrapper extends StatefulWidget {
  final Job job;
  const JobCardWrapper({super.key, required this.job});

  @override
  State<JobCardWrapper> createState() => _JobCardWrapperState();
}

class _JobCardWrapperState extends State<JobCardWrapper> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context, listen: false);

    return Dismissible(
      key: Key(widget.job.id),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.thumb_down, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.startToEnd) {
            viewModel.acceptJob(widget.job); // swipe right → favorite
          } else if (direction == DismissDirection.endToStart) {
            viewModel.rejectJob(widget.job); // swipe left → reject
          }
        });
      },
      child: JobCard(
        job: widget.job,
        onTap: () async {
          // Open details and rebuild on return
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobDetailsScreen(job: widget.job),
            ),
          );
          setState(() {}); // Force rebuild to update background
        },
      ),
    );
  }
}


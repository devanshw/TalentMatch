import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_match/l10n/app_localizations.dart';
import '../models/job.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_card.dart';
import '../services/resume_parser.dart';
import 'job_details_screen.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: l10n.searchJobs,
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
                tooltip: l10n.uploadResume,
                onPressed: () async {
                  final resumeText = await parseResumeFile();
                  if (resumeText != null) {
                    await viewModel.uploadResume(resumeText);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.resumeUploaded)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.jobs.isEmpty
                  ? Center(child: Text(l10n.noJobsFound))
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
            viewModel.acceptJob(widget.job);
          } else if (direction == DismissDirection.endToStart) {
            viewModel.rejectJob(widget.job);
          }
        });
      },
      child: JobCard(
        job: widget.job,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobDetailsScreen(job: widget.job),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
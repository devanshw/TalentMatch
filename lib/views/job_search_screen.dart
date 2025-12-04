import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/job.dart';
import '../viewmodels/job_view_model.dart';
import '../widgets/job_card.dart';
import '../services/resume_parser.dart';
import '../theme/app_theme.dart';
import 'job_details_screen.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);
    final TextEditingController searchController = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.lightBlue, AppTheme.backgroundWhite],
          stops: [0.0, 0.3],
        ),
      ),
      child: Column(
        children: [
          // Search bar + resume upload
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Search for jobs...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: const Icon(Icons.search, 
                          color: AppTheme.primaryBlue),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      ),
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          viewModel.searchJobs(query);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: AppTheme.buttonShadow,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        final resumeText = await parseResumeFile();
                        if (resumeText != null) {
                          await viewModel.uploadResume(resumeText);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 12),
                                    Text("Resume uploaded successfully!"),
                                  ],
                                ),
                                backgroundColor: AppTheme.successGreen,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppTheme.buttonRadius,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Icon(Icons.upload_file, 
                          color: Colors.white, size: 26),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Job list with swipe gestures
          Expanded(
            child: viewModel.isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryBlue),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Finding perfect matches...",
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : viewModel.jobs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppTheme.lightBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search_off,
                                size: 60,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "No jobs found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Try searching for different keywords",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        itemCount: viewModel.jobs.length,
                        itemBuilder: (context, index) {
                          final job = viewModel.jobs[index];
                          return JobCardWrapper(job: job);
                        },
                      ),
          ),
        ],
      ),
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.successGreen, AppTheme.lightGreen],
          ),
          borderRadius: AppTheme.cardRadius,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Colors.white, size: 32),
            SizedBox(height: 4),
            Text(
              "Like",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.lightRed, AppTheme.errorRed],
          ),
          borderRadius: AppTheme.cardRadius,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.thumb_down, color: Colors.white, size: 32),
            SizedBox(height: 4),
            Text(
              "Pass",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
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
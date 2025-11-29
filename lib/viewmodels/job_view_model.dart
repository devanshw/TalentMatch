import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/job_api_service.dart';
import '../services/similarity.dart';

class JobViewModel extends ChangeNotifier {
  final JobApiService apiService;

  JobViewModel({required this.apiService});

  List<Job> jobs = [];
  List<Job> acceptedJobs = [];
  List<Job> rejectedJobs = [];

  // NEW LIST
  List<Job> appliedJobs = [];

  bool isLoading = false;
  String? resumeText;

  Future<void> uploadResume(String text) async {
    resumeText = text;
    notifyListeners();
  }

  Future<void> searchJobs(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      jobs = await apiService.searchJobs(query);

      if (resumeText != null) {
        for (var job in jobs) {
          job.relevance = relevanceScore(resumeText!, job.description);
        }
      }
    } catch (e) {
      print("Search Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void acceptJob(Job job) {
    acceptedJobs.add(job);
    jobs.remove(job);
    rejectedJobs.remove(job);
    notifyListeners();
  }

  void rejectJob(Job job) {
    rejectedJobs.add(job);
    jobs.remove(job);
    notifyListeners();
  }

  void moveToAccepted(Job job) {
    rejectedJobs.remove(job);
    acceptedJobs.add(job);
    notifyListeners();
  }

  void deleteRejected(Job job) {
    rejectedJobs.remove(job);
    notifyListeners();
  }

  void dislikeFromFavorites(Job job) {
    acceptedJobs.remove(job);
    rejectedJobs.add(job);
    notifyListeners();
  }

  // ------------------------------
  // 🔥 APPLIED JOBS LOGIC
  // ------------------------------

  void markApplied(Job job) {
    if (!appliedJobs.contains(job)) {
      appliedJobs.add(job);
    }
    acceptedJobs.remove(job);
    job.hasApplied = true;
    notifyListeners();
  }

  void unmarkApplied(Job job) {
    appliedJobs.remove(job);
    acceptedJobs.add(job);
    job.hasApplied = false;
    notifyListeners();
  }

  void toggleApplied(Job job) {
    if (job.hasApplied) {
      unmarkApplied(job);
    } else {
      markApplied(job);
    }
  }
}

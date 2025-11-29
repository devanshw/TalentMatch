class Job {
  final String id;
  final String title;
  final String employer;
  final String description;
  final String? logo;
  final String? applyLink;
  int relevance;
  bool hasApplied;

  Job({
    required this.id,
    required this.title,
    required this.employer,
    required this.description,
    this.logo,
    this.applyLink,
    this.relevance = 0,
    this.hasApplied = false,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['job_id'] ?? '',
      title: json['job_title'] ?? 'No title',
      employer: json['employer_name'] ?? 'Unknown',
      description: json['job_description'] ?? '',
      logo: json['employer_logo'],
      applyLink: json['job_apply_link'],
    );
  }
}

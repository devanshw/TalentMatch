import 'dart:convert';


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

static String cleanDescription(String? text) {
  if (text == null) return "";

  // Convert the mis-encoded string back to bytes and decode properly
  try {
    final bytes = text.codeUnits; // treat string as bytes
    text = utf8.decode(bytes, allowMalformed: true);
  } catch (_) {
    // fallback: keep original text if decoding fails
  }

  // Replace mis-encoded bullets
  text = (text ?? "").replaceAll(RegExp(r"[•\u2022]"), "•");

  // Normalize spaces but preserve newlines
  text = text.replaceAll(RegExp(r'[ \t]+'), ' ').trim();

  // Return the text
  return text;

}


  /// ---------------------------------------------------------
  /// FACTORY USING THE CLEAN DESCRIPTION ONLY
  /// ---------------------------------------------------------
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['job_id'] ?? '',
      title: json['job_title'] ?? '',
      employer: json['employer_name'] ?? '',
      description: cleanDescription(json['job_description']),
      logo: json['employer_logo'],
      applyLink: json['job_apply_link'],
    );
  }
}

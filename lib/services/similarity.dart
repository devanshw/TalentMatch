import 'dart:math';

String clean(String text) {
  return text
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

Map<String, double> termFrequency(String text) {
  List<String> words = clean(text).split(" ");
  Map<String, double> freq = {};

  for (var w in words) {
    if (w.isEmpty) continue;
    freq[w] = (freq[w] ?? 0) + 1;
  }

  return freq;
}

double cosineSimilarity(Map<String, double> a, Map<String, double> b) {
  double dot = 0.0;
  for (var key in a.keys) {
    if (b.containsKey(key)) dot += a[key]! * b[key]!;
  }

  double magA = sqrt(a.values.fold(0.0, (s, v) => s + v * v));
  double magB = sqrt(b.values.fold(0.0, (s, v) => s + v * v));

  if (magA == 0 || magB == 0) return 0.0;
  return dot / (magA * magB);
}

int relevanceScore(String resume, String jobDesc) {
  final tfA = termFrequency(resume);
  final tfB = termFrequency(jobDesc);

  double sim = cosineSimilarity(tfA, tfB);
  return (sim * 100).round();
}

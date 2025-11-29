import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job.dart';
import '../config/api_config.dart';

class JobApiService {
  Future<List<Job>> searchJobs(String query) async {
    final url = Uri.https(
      "jsearch.p.rapidapi.com",
      "/search",
      {
        "query": query,
        "page": "1",
        "num_pages": "1",
        "country": "us",
        "date_posted": "all",
      },
    );

    final response = await http.get(
      url,
      headers: {
        "x-rapidapi-key": ApiConfig.rapidApiKey,
        "x-rapidapi-host": "jsearch.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      List data = decoded['data'] ?? [];
      return data.map((jobJson) => Job.fromJson(jobJson)).toList();
    } else {
      throw Exception("Failed to load jobs: ${response.statusCode}");
    }
  }
}

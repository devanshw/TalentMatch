import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const JobApp());
}

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobSearchScreen(),
    );
  }
}

class JobSearchScreen extends StatefulWidget {
  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final TextEditingController queryController = TextEditingController();
  bool isLoading = false;
  List jobs = [];

  // ------- API CALL -------
  Future<void> searchJobs(String query) async {
    setState(() => isLoading = true);

    final url = Uri.https(
      "jsearch.p.rapidapi.com",
      "/search",
      {
        "query": query,
        "page": "1",
        "num_pages": "1",
        "country": "us",
        "date_posted": "all"
      },
    );

    final response = await http.get(
      url,
      headers: {
        "x-rapidapi-key": "459bda9a99msh4318b080d5578d3p178a1fjsn21c90ea078c9",  
        "x-rapidapi-host": "jsearch.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      setState(() {
        jobs = decoded["data"] ?? [];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.statusCode}")),
      );
    }

    setState(() => isLoading = false);
  }

  // -------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Job Search")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // QUERY INPUT
            TextField(
              controller: queryController,
              decoration: InputDecoration(
                hintText: "Search jobs (e.g., developer in Chicago)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // SEARCH BUTTON
            ElevatedButton(
              onPressed: () {
                final query = queryController.text.trim();
                if (query.isNotEmpty) {
                  searchJobs(query);
                }
              },
              child: const Text("Search"),
            ),

            const SizedBox(height: 20),

            // RESULTS
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : jobs.isEmpty
                      ? const Center(child: Text("No jobs found"))
                      : ListView.builder(
                          itemCount: jobs.length,
                          itemBuilder: (context, index) {
                            final job = jobs[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: job["employer_logo"] != null
                                    ? Image.network(job["employer_logo"])
                                    : const Icon(Icons.work),
                                title: Text(job["job_title"] ?? "No title"),
                                subtitle:
                                    Text(job["employer_name"] ?? "Unknown"),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

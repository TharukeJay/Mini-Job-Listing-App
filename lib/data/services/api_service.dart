import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jobModel.dart';

class ApiService {
  final String baseUrl = "https://68b6869573b3ec66cec1ceef.mockapi.io/api/v1/";

  Future<List<Job>> fetchJobs() async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}job"));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Job.fromJson(e)).toList();
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load jobs: $e");
    }
  }
}

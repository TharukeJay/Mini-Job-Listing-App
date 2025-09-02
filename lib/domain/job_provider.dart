import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/jobModel.dart';
import '../data/services/api_service.dart';

class JobProvider with ChangeNotifier {
  final ApiService apiService;
  JobProvider(this.apiService);

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  List<Job> _favorites = [];
  List<Job> get favorites => _favorites;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchJobs() async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _jobs = await apiService.fetchJobs();
    } catch (e) {
      _errorMessage = e.toString();
      _jobs = [];
    }
    _loading = false;
    notifyListeners();
  }

  void toggleFavorite(Job job) {
    if (_favorites.any((j) => j.id == job.id)) {
      _favorites.removeWhere((j) => j.id == job.id);
    } else {
      _favorites.add(job);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorites') ?? [];
    _favorites = _jobs.where((job) => ids.contains(job.id)).toList();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.map((j) => j.id).toList());
  }

  List<Job> searchJobs(String query) {
    return _jobs.where((job) =>
    job.title.toLowerCase().contains(query.toLowerCase()) ||
        job.location.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}

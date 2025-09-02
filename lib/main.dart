import 'package:flutter/material.dart';
import 'package:mini_job/presentation/screens/job_list_page.dart';
import 'package:mini_job/services/api_service.dart';
import 'package:provider/provider.dart';
import 'domain/job_provider.dart';
import 'domain/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobProvider(ApiService())..fetchJobs()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const JobApp(),
    ),
  );
}

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Job Listing App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const JobListPage(),
    );
  }
}

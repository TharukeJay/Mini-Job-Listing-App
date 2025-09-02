import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/job_provider.dart';
import 'job_details_page.dart';
import 'favorites_page.dart';
import '../../domain/theme_provider.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final jobs = query.isEmpty
        ? jobProvider.jobs
        : jobProvider.searchJobs(query);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Listings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Switch(
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                      (states) {
                    if (themeProvider.isDark) {
                      return const Icon(Icons.dark_mode, color: Colors.black);
                    } else {
                      return const Icon(Icons.light_mode, color: Colors.yellow);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: jobProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : jobProvider.errorMessage != null
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(jobProvider.errorMessage!,
                style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => jobProvider.fetchJobs(),
              child: const Text("Retry"),
            )
          ],
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search by title or location",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                final isFav = jobProvider.favorites.any((j) => j.id == job.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    elevation: 6,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => JobDetailsPage(job: job),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              child: Text(job.id),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    job.company,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    "${job.location} • ${job.type}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => jobProvider.toggleFavorite(job),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(scale: animation, child: child);
                                },
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  key: ValueKey<bool>(isFav),
                                  color: isFav ? Colors.red : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

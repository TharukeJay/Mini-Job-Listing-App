import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/job_provider.dart';
import '../../models/jobModel.dart';


class JobDetailsPage extends StatelessWidget {
  final Job job;
  const JobDetailsPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
        actions: [
          GestureDetector(
            onTap: () => jobProvider.toggleFavorite(job),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                jobProvider.favorites.any((j) => j.id == job.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                key: ValueKey<bool>(
                    jobProvider.favorites.any((j) => j.id == job.id)),
                color: jobProvider.favorites.any((j) => j.id == job.id)
                    ? Colors.red
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              job.company,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "${job.location} • ${job.type}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (job.salary != null)
              Text(
                "Salary: ${job.salary}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            Text(
              job.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Applied for the job!")),
                );
              },
              child: const Text("Apply Now"),
            )
          ],
        ),
      ),
    );
  }
}

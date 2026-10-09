import 'package:flutter/material.dart';
import '../../models/activity_model.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  Future<void> _confirmRegister(ClubActivity activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Registration'),
        content: Text(
            'Register for ${activity.title}?\n\n${activity.date} • ${activity.time}\n${activity.venue}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Register'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        activity.isRegistered = true;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered for ${activity.title}!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activities & Workshops')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: dummyActivities.length,
        itemBuilder: (context, index) {
          final activity = dummyActivities[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(activity.clubName,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text('Date: ${activity.date}'),
                        Text('Time: ${activity.time}'),
                        Text('Venue: ${activity.venue}'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: activity.isRegistered
                        ? null
                        : () => _confirmRegister(activity),
                    child: Text(
                        activity.isRegistered ? 'Registered ✓' : 'Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
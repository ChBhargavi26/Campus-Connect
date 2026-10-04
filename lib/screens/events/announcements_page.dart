import 'package:flutter/material.dart';
import '../../models/announcement.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sampleAnnouncements.length,
        itemBuilder: (context, index) {
          final a = sampleAnnouncements[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.campaign, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(a.title,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(a.message),
                  const SizedBox(height: 8),
                  Text('📅 ${a.date}',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
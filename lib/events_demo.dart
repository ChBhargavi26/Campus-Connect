import 'package:flutter/material.dart';
import 'screens/events/events_page.dart';
import 'screens/events/announcements_page.dart';

void main() => runApp(const MaterialApp(home: DemoHome()));

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member 2 Demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EventsPage())),
              child: const Text('Events'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AnnouncementsPage())),
              child: const Text('Announcements'),
            ),
          ],
        ),
      ),
    );
  }
}
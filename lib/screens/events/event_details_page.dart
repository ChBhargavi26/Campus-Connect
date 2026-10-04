import 'package:flutter/material.dart';
import '../../models/event.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;
  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool registered = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('📅 Date: ${event.date}'),
            Text('⏰ Time: ${event.time}'),
            Text('📍 Venue: ${event.venue}'),
            const SizedBox(height: 16),
            Text(event.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registered
                    ? null
                    : () {
                        setState(() => registered = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registered successfully!')),
                        );
                      },
                child: Text(registered ? 'Registered ✅' : 'Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
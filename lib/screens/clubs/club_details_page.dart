import 'package:flutter/material.dart';
import '../../models/club_model.dart';

class ClubDetailsPage extends StatefulWidget {
  final Club club;

  const ClubDetailsPage({super.key, required this.club});

  @override
  State<ClubDetailsPage> createState() => _ClubDetailsPageState();
}

class _ClubDetailsPageState extends State<ClubDetailsPage> {
  void _toggleJoin() {
    setState(() {
      widget.club.isJoined = !widget.club.isJoined;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.club.isJoined
            ? 'You joined ${widget.club.name}!'
            : 'You left ${widget.club.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final club = widget.club;

    return Scaffold(
      appBar: AppBar(title: Text(club.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                club.imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.groups, size: 70),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(club.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Chip(label: Text(club.category)),
            const SizedBox(height: 16),

            const Text('About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(club.description),
            const SizedBox(height: 16),

            const Text('Members',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 8),
                Text('${club.membersCount} members'),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Upcoming Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...club.activities.map(
              (activity) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event),
                title: Text(activity),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _toggleJoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: club.isJoined ? Colors.green : null,
                  foregroundColor: club.isJoined ? Colors.white : null,
                ),
                child: Text(club.isJoined ? 'Joined ✓' : 'Join Club'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
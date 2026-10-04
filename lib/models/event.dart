class Event {
  final String title;
  final String date;
  final String time;
  final String venue;
  final String description;

  const Event({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.description,
  });
}

const List<Event> sampleEvents = [
  Event(
    title: 'Flutter Workshop',
    date: '20 Oct 2026',
    time: '10:00 AM',
    venue: 'Seminar Hall',
    description: 'Hands-on workshop on building Flutter apps.',
  ),
  Event(
    title: 'Hackathon',
    date: '25 Oct 2026',
    time: '9:00 AM',
    venue: 'CSE Block',
    description: '24-hour coding competition. Teams of up to 4.',
  ),
  Event(
    title: 'Cultural Fest',
    date: '2 Nov 2026',
    time: '4:00 PM',
    venue: 'Main Ground',
    description: 'Music, dance and fun events for all students.',
  ),
];
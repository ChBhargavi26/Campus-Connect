class ClubActivity {
  final String id;
  final String title;
  final String clubName;
  final String date;
  final String time;
  final String venue;
  bool isRegistered;

  ClubActivity({
    required this.id,
    required this.title,
    required this.clubName,
    required this.date,
    required this.time,
    required this.venue,
    this.isRegistered = false,
  });
}

// Dummy data (replace with Firestore later)
final List<ClubActivity> dummyActivities = [
  ClubActivity(
    id: '1',
    title: 'Flutter Workshop',
    clubName: 'Coding Club',
    date: '15 Oct 2026',
    time: '10:00 AM',
    venue: 'Seminar Hall',
  ),
  ClubActivity(
    id: '2',
    title: 'Hackathon',
    clubName: 'Coding Club',
    date: '20 Oct 2026',
    time: '9:00 AM',
    venue: 'Computer Lab 2',
  ),
  ClubActivity(
    id: '3',
    title: 'Dance Workshop',
    clubName: 'Cultural Club',
    date: '22 Oct 2026',
    time: '4:00 PM',
    venue: 'Auditorium',
  ),
  ClubActivity(
    id: '4',
    title: 'Football Trials',
    clubName: 'Sports Club',
    date: '25 Oct 2026',
    time: '6:00 AM',
    venue: 'College Ground',
  ),
  ClubActivity(
    id: '5',
    title: 'Photo Walk',
    clubName: 'Photography Club',
    date: '28 Oct 2026',
    time: '5:00 PM',
    venue: 'Campus Garden',
  ),
];
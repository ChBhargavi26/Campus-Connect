class Club {
  final String id;
  final String name;
  final String description;
  final String category;
  final int membersCount;
  final String imageUrl;
  final List<String> activities;
  bool isJoined;

  Club({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.membersCount,
    required this.imageUrl,
    required this.activities,
    this.isJoined = false,
  });
}

// Dummy data (replace with Firestore later)
final List<Club> dummyClubs = [
  Club(
    id: '1',
    name: 'Coding Club',
    description: 'Learn programming, build projects and join hackathons.',
    category: 'Tech',
    membersCount: 120,
    imageUrl: 'https://via.placeholder.com/300',
    activities: ['Flutter Workshop', 'Hackathon', 'DSA Contest'],
  ),
  Club(
    id: '2',
    name: 'Cultural Club',
    description: 'Dance, music, drama and cultural fest events.',
    category: 'Cultural',
    membersCount: 85,
    imageUrl: 'https://via.placeholder.com/300',
    activities: ['Dance Workshop', 'Singing Contest'],
  ),
  Club(
    id: '3',
    name: 'Sports Club',
    description: 'Cricket, football, athletics and inter-college matches.',
    category: 'Sports',
    membersCount: 150,
    imageUrl: 'https://via.placeholder.com/300',
    activities: ['Football Trials', 'Cricket Match'],
  ),
  Club(
    id: '4',
    name: 'Photography Club',
    description: 'Capture campus life and learn photo editing.',
    category: 'Cultural',
    membersCount: 60,
    imageUrl: 'https://via.placeholder.com/300',
    activities: ['Photo Walk', 'Editing Workshop'],
  ),
];
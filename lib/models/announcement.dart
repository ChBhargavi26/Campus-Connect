class Announcement {
  final String title;
  final String message;
  final String date;

  const Announcement({
    required this.title,
    required this.message,
    required this.date,
  });
}

const List<Announcement> sampleAnnouncements = [
  Announcement(
    title: 'Mid-Semester Exams',
    message: 'Mid-semester examinations will begin from 20 October.',
    date: '04 Oct 2026',
  ),
  Announcement(
    title: 'Library Timings',
    message: 'The library will stay open until 8:00 PM during exams.',
    date: '03 Oct 2026',
  ),
  Announcement(
    title: 'Fee Payment Reminder',
    message: 'Last date to pay semester fees is 15 October.',
    date: '01 Oct 2026',
  ),
];
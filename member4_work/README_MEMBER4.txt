CAMPUS CONNECT - MEMBER 4 FILES

These are new Member 4 files intended to be copied into the existing Flutter repository.
They do not replace the existing login, profile, events, clubs, or authentication files.

FILES
1. lib/screens/member4/lost_found_page.dart
   - Lost/Found report form
   - Stores and streams reports from Cloud Firestore collection: lost_found_items
   - Allows an open report to be marked Resolved

2. lib/screens/member4/campus_services_page.dart
   - Campus service/help cards
   - Opens Lost & Found
   - Uses general guidance; replace with verified college contacts before final demo

3. lib/screens/member4/campus_home_shell.dart
   - Bottom navigation and home dashboard
   - Reuses existing EventsPage, ClubsPage and ProfileScreen

INTEGRATION STEP (coordinate with Member 1)
After testing, change the successful-login destination in lib/screens/login_screen.dart to:

Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const CampusHomeShell()),
);

Also add this import to login_screen.dart:
import 'member4/campus_home_shell.dart';

Because login_screen.dart belongs to the authentication work, coordinate this small integration change with Member 1 instead of overwriting their file.

FIREBASE
- Existing pubspec.yaml already includes cloud_firestore and firebase_core.
- The app must initialize Firebase (the existing main.dart does this).
- Create/confirm Firestore database and configure rules before testing writes.
- The collection `lost_found_items` is created automatically on the first successful write.
- Use suitable security rules for your app. Do not deploy unrestricted production rules.

TEST
1. Run `flutter pub get`
2. Run `flutter analyze`
3. Run `flutter run`
4. Sign in, open Services > Lost & Found, submit a test report, and verify it appears.
5. Mark it Resolved and verify the status changes.

GIT: Stage only your files plus any integration edits agreed with Member 1. Do not use `git add .` if you need to ensure only Member 4 changes are committed.

import 'package:flutter/material.dart';
import '../clubs/clubs_page.dart';
import '../events/events_page.dart';
import '../profile_screen.dart';
import 'campus_services_page.dart';

/// Main bottom-navigation shell for integrating the existing member modules.
/// Use this as the post-login destination after coordinating with Member 1.
class CampusHomeShell extends StatefulWidget {
  const CampusHomeShell({super.key});

  @override
  State<CampusHomeShell> createState() => _CampusHomeShellState();
}

class _CampusHomeShellState extends State<CampusHomeShell> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    _HomeDashboard(onOpenTab: (index) => setState(() => _selectedIndex = index)),
    const EventsPage(),
    const ClubsPage(),
    const CampusServicesPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'Clubs'),
          NavigationDestination(icon: Icon(Icons.support_agent_outlined), selectedIcon: Icon(Icons.support_agent), label: 'Services'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  final ValueChanged<int> onOpenTab;
  const _HomeDashboard({required this.onOpenTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Connect'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF7C3AED)]),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Your campus, connected.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Explore events, student clubs and campus support in one place.', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 22),
          const Text('Explore', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _HomeTile(icon: Icons.event, title: 'Events & Announcements', subtitle: 'See what is happening on campus', onTap: () => onOpenTab(1)),
          _HomeTile(icon: Icons.groups, title: 'Clubs & Activities', subtitle: 'Find clubs and workshops', onTap: () => onOpenTab(2)),
          _HomeTile(icon: Icons.support_agent, title: 'Campus Services', subtitle: 'Find help and important services', onTap: () => onOpenTab(3)),
          _HomeTile(icon: Icons.find_in_page, title: 'Lost & Found', subtitle: 'Report or find an item', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CampusServicesPage()))),
          _HomeTile(icon: Icons.person, title: 'Student Profile', subtitle: 'View your student information', onTap: () => onOpenTab(4)),
        ],
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _HomeTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFFE8EEFF), child: Icon(icon, color: const Color(0xFF2563EB))),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      );
}

import 'package:flutter/material.dart';
import 'lost_found_page.dart';

/// Member 4: campus help and important campus contacts.
class CampusServicesPage extends StatelessWidget {
  const CampusServicesPage({super.key});

  static const List<_CampusService> _services = [
    _CampusService('College Office', 'Academic queries, certificates and administration', Icons.account_balance_outlined, 'Contact the college office during working hours.'),
    _CampusService('Library', 'Books, reading rooms and library support', Icons.local_library_outlined, 'Visit the library help desk for book and account enquiries.'),
    _CampusService('Medical Assistance', 'First aid and health-related help on campus', Icons.medical_services_outlined, 'For urgent emergencies, contact local emergency services or campus security immediately.'),
    _CampusService('Campus Security', 'Safety, security and urgent campus concerns', Icons.shield_outlined, 'Contact the campus security desk or college administration.'),
    _CampusService('IT Support', 'Wi-Fi, lab computers and student portal issues', Icons.computer_outlined, 'Report the device, lab or network issue to the IT support team.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Services')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF7C3AED)]),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.support_agent, color: Colors.white, size: 38),
              SizedBox(height: 12),
              Text('How can we help?', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('Find campus support and report lost or found belongings.', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.find_in_page_outlined)),
              title: const Text('Lost & Found', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Report or browse lost and found items'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LostFoundPage())),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(4, 18, 4, 8),
            child: Text('Campus help and contacts', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          ),
          ..._services.map((service) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: const Color(0xFFE8EEFF), child: Icon(service.icon, color: const Color(0xFF2563EB))),
                  title: Text(service.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(service.subtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text(service.title),
                      content: Text(service.helpText),
                      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close'))],
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 12),
          const Text('Note: Replace the general guidance above with verified college contact numbers before your final demonstration.', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
        ],
      ),
    );
  }
}

class _CampusService {
  final String title;
  final String subtitle;
  final IconData icon;
  final String helpText;
  const _CampusService(this.title, this.subtitle, this.icon, this.helpText);
}

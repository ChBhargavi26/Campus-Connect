import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Member 4: Lost & Found module.
/// Reports are stored in the Cloud Firestore `lost_found_items` collection.
class LostFoundPage extends StatefulWidget {
  const LostFoundPage({super.key});

  @override
  State<LostFoundPage> createState() => _LostFoundPageState();
}

class _LostFoundPageState extends State<LostFoundPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  String _reportType = 'Lost';
  bool _saving = false;

  final CollectionReference<Map<String, dynamic>> _items =
      FirebaseFirestore.instance.collection('lost_found_items');

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await _items.add({
        'type': _reportType,
        'itemName': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'location': _locationController.text.trim(),
        'contact': _contactController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'Open',
      });
      if (!mounted) return;
      _nameController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _contactController.clear();
      setState(() => _reportType = 'Lost');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully')),
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save report: ${e.message ?? e.code}')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _markResolved(String id) async {
    try {
      await _items.doc(id).update({'status': 'Resolved'});
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update report: ${e.message ?? e.code}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lost & Found')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showReportForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Report item'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _items.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Unable to load reports. Check your Firestore setup and rules.'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(24),
              children: const [
                SizedBox(height: 70),
                Icon(Icons.search, size: 72, color: Colors.blueGrey),
                SizedBox(height: 12),
                Center(child: Text('No reports yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                SizedBox(height: 8),
                Center(child: Text('Use “Report item” to post a lost or found item.')),
              ],
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data();
              final isLost = (data['type'] ?? 'Lost') == 'Lost';
              final isResolved = (data['status'] ?? 'Open') == 'Resolved';
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                          backgroundColor: isLost ? Colors.orange.shade100 : Colors.green.shade100,
                          child: Icon(isLost ? Icons.search : Icons.inventory_2_outlined,
                              color: isLost ? Colors.deepOrange : Colors.green.shade800),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(data['itemName'] ?? 'Unnamed item',
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                        Chip(label: Text(isResolved ? 'Resolved' : (data['type'] ?? 'Lost'))),
                      ]),
                      const SizedBox(height: 10),
                      Text(data['description'] ?? ''),
                      const SizedBox(height: 8),
                      _detail(Icons.place_outlined, 'Location', data['location'] ?? 'Not provided'),
                      _detail(Icons.phone_outlined, 'Contact', data['contact'] ?? 'Not provided'),
                      if (!isResolved)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => _markResolved(doc.id),
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text('Mark resolved'),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _detail(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 7),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ]),
      );

  void _showReportForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
                const Text('Report a lost or found item', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Lost', label: Text('I lost an item'), icon: Icon(Icons.search)),
                    ButtonSegment(value: 'Found', label: Text('I found an item'), icon: Icon(Icons.inventory_2_outlined)),
                  ],
                  selected: {_reportType},
                  onSelectionChanged: (value) {
                    setState(() => _reportType = value.first);
                    setSheetState(() {});
                  },
                ),
                const SizedBox(height: 12),
                _field(_nameController, 'Item name', Icons.category_outlined),
                _field(_descriptionController, 'Description', Icons.notes_outlined, maxLines: 2),
                _field(_locationController, 'Last seen / found location', Icons.place_outlined),
                _field(_contactController, 'Contact details', Icons.phone_outlined, keyboardType: TextInputType.text),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: _saving ? null : () async {
                    await _submitReport();
                    if (mounted && !_saving && Navigator.of(sheetContext).canPop()) {
                      Navigator.of(sheetContext).pop();
                    }
                  },
                  icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
                  label: Text(_saving ? 'Submitting...' : 'Submit report'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon), border: const OutlineInputBorder()),
        validator: (value) => value == null || value.trim().isEmpty ? 'Please enter $label'.toLowerCase() : null,
      ),
    );
  }
}

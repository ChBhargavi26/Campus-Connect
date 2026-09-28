import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String studentId;
  final String branch;
  final String year;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.studentId,
    required this.branch,
    required this.year,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController studentIdController;

  late String selectedBranch;
  late String selectedYear;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    studentIdController = TextEditingController(text: widget.studentId);

    selectedBranch = widget.branch;
    selectedYear = widget.year;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    studentIdController.dispose();
    super.dispose();
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is not logged in'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'name': nameController.text.trim(),
        'studentId': studentIdController.text.trim(),
        'branch': selectedBranch,
        'year': selectedYear,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  InputDecoration fieldDecoration({
    required String label,
    required IconData icon,
    required Color iconColor,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: iconColor),
      filled: true,
      fillColor: const Color(0xFFF5F7FF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: iconColor, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),

      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.20),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFFE8EEFF),
                        child: Icon(
                          Icons.person_rounded,
                          size: 52,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Update Your Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Keep your student information up to date',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Name
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: fieldDecoration(
                  label: 'Full Name',
                  icon: Icons.person_rounded,
                  iconColor: const Color(0xFF2563EB),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailController,
                readOnly: true,
                decoration: fieldDecoration(
                  label: 'Email',
                  icon: Icons.email_rounded,
                  iconColor: Colors.grey,
                ),
              ),

              const SizedBox(height: 16),

              // Student ID
              TextFormField(
                controller: studentIdController,
                decoration: fieldDecoration(
                  label: 'Student ID',
                  icon: Icons.badge_rounded,
                  iconColor: const Color(0xFF0891B2),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your student ID';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Branch
              DropdownButtonFormField<String>(
                initialValue: selectedBranch,
                decoration: fieldDecoration(
                  label: 'Branch',
                  icon: Icons.school_rounded,
                  iconColor: const Color(0xFF059669),
                ),
                items: const [
                  DropdownMenuItem(value: 'CSE', child: Text('CSE')),
                  DropdownMenuItem(value: 'ECE', child: Text('ECE')),
                  DropdownMenuItem(value: 'EEE', child: Text('EEE')),
                  DropdownMenuItem(value: 'IT', child: Text('IT')),
                  DropdownMenuItem(value: 'AIML', child: Text('AIML')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedBranch = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // Year
              DropdownButtonFormField<String>(
                initialValue: selectedYear,
                decoration: fieldDecoration(
                  label: 'Year',
                  icon: Icons.calendar_month_rounded,
                  iconColor: const Color(0xFFEA580C),
                ),
                items: const [
                  DropdownMenuItem(value: '1st Year', child: Text('1st Year')),
                  DropdownMenuItem(value: '2nd Year', child: Text('2nd Year')),
                  DropdownMenuItem(value: '3rd Year', child: Text('3rd Year')),
                  DropdownMenuItem(value: '4th Year', child: Text('4th Year')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedYear = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 28),

              // Save button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : saveProfile,
                  icon: isLoading
                      ? const SizedBox(
                          height: 21,
                          width: 21,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save_rounded, color: Colors.white),
                  label: Text(
                    isLoading ? 'SAVING...' : 'SAVE CHANGES',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                  label: const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Campus Connect',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

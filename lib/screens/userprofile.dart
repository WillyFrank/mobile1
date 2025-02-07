import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  final String username = 'John Doe';
  final String phoneNumber = '+1 (555) 123-4567';

  final List<LostItem> lostItems = [
    LostItem(
      name: 'Blue Backpack',
      date: '2024-08-15',
      status: 'Pending',
    ),
    LostItem(
      name: 'Smartphone',
      date: '2024-08-10',
      status: 'Found',
    ),
    LostItem(
      name: 'Umbrella',
      date: '2024-07-30',
      status: 'Closed',
    ),
  ];

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins()),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildPersonalInfo(),
            _buildLostItemsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue[800],
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.blue[800]),
          ),
          const SizedBox(height: 16),
          Text(
            username,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.phone, phoneNumber),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            onPressed: () {
              // TODO: Implement edit profile functionality
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }
}

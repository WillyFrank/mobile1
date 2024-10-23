import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  final String username = 'John Doe';
  final String email = 'john.doe@example.com';
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
          Text(
            'Personal Information',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.email, email),
          const SizedBox(height: 8),
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

  Widget _buildLostItemsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reported Lost Items',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lostItems.length,
            itemBuilder: (context, index) {
              return _buildLostItemCard(lostItems[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLostItemCard(LostItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(
          item.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Reported on ${item.date}',
          style: GoogleFonts.poppins(),
        ),
        trailing: Chip(
          label: Text(
            item.status,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(item.status),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Found':
        return Colors.green;
      case 'Closed':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}

class LostItem {
  final String name;
  final String date;
  final String status;

  LostItem({
    required this.name,
    required this.date,
    required this.status,
  });
}

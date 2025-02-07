import 'package:fina_year_pr/screens/contact.dart';
import 'package:fina_year_pr/screens/logout.dart';
import 'package:flutter/material.dart';
import 'package:fina_year_pr/screens/notification.dart';
import 'package:fina_year_pr/screens/registerlostitems.dart';
import 'package:fina_year_pr/screens/userprofile.dart';
import 'package:fina_year_pr/screens/viewfounditems.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Dashboard'),
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/lost-found-searching-finding-missing-260nw-1168647070.webp'), // Replace with your image path
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
          ),
          // Overlay content (Text and other elements)
          const Center(
            child: Text(
              'Welcome to Lost and Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'FindMyStuff',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.visibility,
            title: 'View Founded Items',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewFoundItemsScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.add_circle_outline,
            title: 'Register Lost Item',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterLostItemScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.person,
            title: 'Profile',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen())),
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LogoutScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.contact_phone,
            title: 'Contact Office',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.lightBlue),
      title: Text(title),
      onTap: onTap,
    );
  }
}

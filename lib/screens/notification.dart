import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            const Text('Notifications', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // TODO: Implement home navigation
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            image: 'assets/profile1.jpg',
            name: 'Dennisa Nedry',
            message:
                'Attention all passengers: A black leather wallet has been found near Gate 23. If this belongs to you, please use the Lost and Found system to claim your item.',
            date: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            image: 'assets/profile2.jpg',
            name: 'Dennis Nedry',
            message:
                'A white iPhone 13 has been reported lost near the food court. If you have found this item, kindly report it using the Lost and Found system. Your honesty is greatly appreciated.',
            date: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            image: 'assets/profile3.jpg',
            name: 'Dennis Nedry',
            message:
                'A set of car keys with a red keychain has been found in the parking lot area C. Please use the Lost and Found system with proper identification to retrieve your keys',
            date: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            image: 'assets/profile4.jpg',
            name: 'Dennis Nedry',
            message:
                'A blue Nike backpack containing school textbooks was left on Bus 42. If you have any information or have found this item, please use the Lost and Found system to report it immediately.',
            date: 'Last Wednesday at 9:42 AM',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String image,
    required String name,
    required String message,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(message),
                const SizedBox(height: 4),
                Text(date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

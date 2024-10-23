import 'package:flutter/material.dart';

class ViewFoundItemsScreen extends StatelessWidget {
  const ViewFoundItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for found items
    final List<Map<String, String>> foundItems = [
      {'title': 'Black Wallet', 'description': 'Found on Bus 123, 22-Aug-2024'},
      {'title': 'Umbrella', 'description': 'Found on Bus 456, 23-Aug-2024'},
      {'title': 'Laptop Bag', 'description': 'Found on Bus 789, 24-Aug-2024'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Found Items'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: foundItems.length,
        itemBuilder: (context, index) {
          final item = foundItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.search, color: Colors.blueAccent),
              title: Text(item['title']!),
              subtitle: Text(item['description']!),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  // Handle item tap, e.g., navigate to item details
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewFoundItemsScreen extends StatelessWidget {
  const ViewFoundItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              trailing: ElevatedButton(
                onPressed: () {
                  _showClaimDialog(context, item['title']!);
                },
                child: const Text('Claim'),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showClaimDialog(BuildContext context, String itemTitle) {
    final ticketIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Claim $itemTitle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your Ticket ID to claim this item:'),
              const SizedBox(height: 16),
              TextField(
                controller: ticketIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ticket ID',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final ticketId = ticketIdController.text;
                if (ticketId.isNotEmpty) {
                  _submitClaim(context, itemTitle, ticketId);
                  Navigator.of(context).pop();
                } else {
                  _showSnackBar(context, 'Please enter your Ticket ID');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitClaim(
      BuildContext context, String itemTitle, String ticketId) async {
    const apiUrl = 'http://192.168.1.77:8080/claims';
    final claimData = {
      'itemTitle': itemTitle,
      'ticketId': ticketId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(claimData),
      );

      if (response.statusCode == 200) {
        _showSnackBar(context, 'Claim submitted successfully for $itemTitle');
      } else {
        _showSnackBar(
            context, 'Failed to submit claim: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showSnackBar(context, 'Error: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

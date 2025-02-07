// Flutter: Updated RegisterLostItemScreen
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterLostItemScreen extends StatefulWidget {
  const RegisterLostItemScreen({super.key});

  @override
  _RegisterLostItemScreenState createState() => _RegisterLostItemScreenState();
}

class _RegisterLostItemScreenState extends State<RegisterLostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateLost;
  final TextEditingController _ticketIdController = TextEditingController();
  final TextEditingController _seatNumberController = TextEditingController();
  final TextEditingController _preferredNameController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _dateLost != null) {
      final ticketId = _ticketIdController.text.trim();
      final seatNumber = _seatNumberController.text.trim();
      final preferredName = _preferredNameController.text.trim();
      final category = _categoryController.text.trim();
      final dateLost = _dateLost!.toIso8601String();
      const String apiUrl = "http://192.168.1.10:8080/lostItems";

      final Map<String, dynamic> requestBody = {
        "ticket_id": ticketId,
        "seatNumber": seatNumber,
        "preferredName": preferredName,
        "category": category,
        "dateLost": dateLost,
        "status": "Active"
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201) {
          _showSnackBar('Lost item registered successfully!');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RatingsAndFeedbackScreen()),
          );
        } else {
          final responseBody = jsonDecode(response.body);
          _showSnackBar(
              'Failed to register item: ${responseBody['message'] ?? 'Unknown error'}');
        }
      } catch (e) {
        _showSnackBar('Error: Could not connect to the server.');
      }
    } else {
      _showSnackBar('Please fill all required fields');
    }
  }

  @override
  void dispose() {
    _ticketIdController.dispose();
    _seatNumberController.dispose();
    _preferredNameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Lost Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _ticketIdController,
                decoration: const InputDecoration(
                    labelText: 'Ticket ID', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ticket ID is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _seatNumberController,
                decoration: const InputDecoration(
                    labelText: 'Seat Number', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Seat Number is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _preferredNameController,
                decoration: const InputDecoration(
                    labelText: 'Preferred Name', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Preferred Name is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                    labelText: 'Category', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Category is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Date Lost',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder()),
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateLost ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateLost = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                    text: _dateLost != null
                        ? DateFormat('dd/MM/yyyy').format(_dateLost!)
                        : ''),
                validator: (value) =>
                    _dateLost == null ? 'Date is required' : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                    onPressed: _submitForm, child: const Text('Submit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingsAndFeedbackScreen extends StatelessWidget {
  const RatingsAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ratings and Feedback')),
      body: const Center(child: Text('Thank you for your feedback!')),
    );
  }
}

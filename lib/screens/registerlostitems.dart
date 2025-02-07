import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _dateLost != null) {
      final ticketId = _ticketIdController.text.trim();
      final seatNumber = _seatNumberController.text.trim();

      debugPrint('Ticket ID: $ticketId');
      debugPrint('Seat Number: $seatNumber');
      debugPrint('Date Lost: ${DateFormat('dd/MM/yyyy').format(_dateLost!)}');

      _showSnackBar('Lost item registered successfully!');
      Navigator.pop(context); // Navigate back after submission
    } else {
      _showSnackBar('Please fill all required fields');
    }
  }

  @override
  void dispose() {
    _ticketIdController.dispose();
    _seatNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Lost Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ticket ID Field
              TextFormField(
                controller: _ticketIdController,
                decoration: const InputDecoration(
                  labelText: 'Ticket ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ticket ID is required'
                    : null,
              ),
              const SizedBox(height: 16),
              // Seat Number Field
              TextFormField(
                controller: _seatNumberController,
                decoration: const InputDecoration(
                  labelText: 'Seat Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Seat Number is required'
                    : null,
              ),
              const SizedBox(height: 16),
              // Date Lost Picker
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date Lost',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
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
                      : '',
                ),
                validator: (value) =>
                    _dateLost == null ? 'Date is required' : null,
              ),
              const SizedBox(height: 24),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io'; // For using File
import 'package:fina_year_pr/screens/ratingandfeedback.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking functionality
import 'package:intl/intl.dart';

class RegisterLostItemScreen extends StatefulWidget {
  const RegisterLostItemScreen({super.key});

  @override
  _RegisterLostItemScreenState createState() => _RegisterLostItemScreenState();
}

class _RegisterLostItemScreenState extends State<RegisterLostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateLost;
  XFile? _selectedImage;
  String? _selectedLocation;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _selectLocation() async {
    // Placeholder for location picker (replace with actual geolocation functionality)
    setState(() {
      _selectedLocation = 'Selected Location';
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission (e.g., save data to a database or send to a server)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lost item registered successfully!')),
      );

      // Navigate to the Ratings and Feedback screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FeedbackScreen()),
      );
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Register Lost Item',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Handle home button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600, // Optional: Restrict the width for larger screens
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        child: SizedBox(
                          height: 120,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 40),
                              SizedBox(height: 8),
                              Text('Attach Images'),
                            ],
                          ),
                        ),
                      ),
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Image.file(
                            File(_selectedImage!.path), // Convert XFile to File
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Date Lost',
                          suffixIcon: Icon(Icons.calendar_today),
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
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              _selectedLocation ?? 'Add Geotag (Location)',
                          suffixIcon: const Icon(Icons.location_on),
                        ),
                        readOnly: true,
                        onTap: _selectLocation,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Type here (e.g., color, brand, size)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Chatbot helpdesk screen or show help dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Chatbot helpdesk not implemented')),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.chat),
      ),
    );
  }
}

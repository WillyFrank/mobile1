import 'dart:io'; // For using File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking functionality

class RegisterFoundItemsScreen extends StatefulWidget {
  const RegisterFoundItemsScreen({super.key});

  @override
  _RegisterFoundItemsScreenState createState() =>
      _RegisterFoundItemsScreenState();
}

class _RegisterFoundItemsScreenState extends State<RegisterFoundItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  XFile? _selectedImage;
  String? _selectedLocation;

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      } else {
        // Handle the case when no image is selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      // Handle errors, such as permission denied or failure to pick an image
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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
        const SnackBar(content: Text('Found item registered successfully!')),
      );
      Navigator.pop(context); // Return to Dashboard after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Found Items'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Attach Images'),
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
              TextButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.date_range),
                label: Text(_selectedDate == null
                    ? 'Select Date Found'
                    : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: _selectLocation,
                icon: const Icon(Icons.location_on),
                label: Text(_selectedLocation ?? 'Add Geotag (Location)'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
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

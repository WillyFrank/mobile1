import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I report a lost item?',
      answer:
          'To report a lost item, go to the home screen and tap on "Report Lost Item". Fill in the details about your lost item, including a description, when and where you lost it, and any other relevant information.',
    ),
    FAQItem(
      question: 'What should I do if I find someone else\'s item?',
      answer:
          'If you find someone else\'s item, please report it as a found item in the app. Go to the home screen and tap on "Report Found Item". Provide as much detail as possible about the item and where you found it.',
    ),
    FAQItem(
      question: 'How does the item matching process work?',
      answer:
          'Our app uses AI algorithms to match lost items with found items based on descriptions, locations, and timestamps. When a potential match is found, both the owner and the finder will be notified.',
    ),
    FAQItem(
      question: 'Is my personal information secure?',
      answer:
          'Yes, we take data security very seriously. All personal information is encrypted and stored securely. We never share your information with third parties without your explicit consent.',
    ),
    FAQItem(
      question: 'How can I track the status of my lost item?',
      answer:
          'You can track the status of your lost item by going to your profile and checking the "Reported Lost Items" section. Each item will show its current status, such as "Pending", "Potential Match Found", or "Recovered".',
    ),
  ];

  HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support', style: GoogleFonts.poppins()),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Frequently Asked Questions',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          ...faqItems.map((item) => _buildFAQItem(item)),
          const SizedBox(height: 32),
          Text(
            'Still need help?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.email),
            label: const Text('Contact Support'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              //  Implement contact support functionality
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.chat),
            label: const Text('Live Chat'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              //  Implement live chat functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(FAQItem item) {
    return ExpansionTile(
      title: Text(
        item.question,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            item.answer,
            style: GoogleFonts.poppins(),
          ),
        ),
      ],
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

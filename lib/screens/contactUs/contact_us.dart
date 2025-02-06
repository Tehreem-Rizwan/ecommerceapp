import 'package:ecommerceapp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firebase Firestore package

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // Controllers for the TextFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Method to save data to Firestore
  void _saveContactData() async {
    await FirebaseFirestore.instance.collection('contact_us').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'company': _companyController.text,
      'message': _messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Show a confirmation message after saving the data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Your message has been sent!')),
    );

    // Clear the form after submission
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _companyController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT US FOR ANY QUESTIONS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField('Your Name', _nameController),
              SizedBox(height: 18),
              _buildTextField('Your Email', _emailController),
              SizedBox(height: 18),
              _buildTextField('Phone Number', _phoneController),
              SizedBox(height: 18),
              _buildTextField('Company', _companyController),
              SizedBox(height: 18),
              Text('Your Message',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 14),
              TextField(
                controller: _messageController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Ask your question...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kprimaryColor),
                  onPressed: _saveContactData,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: ksecondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'FREQUENTLY ASKED QUESTIONS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              _buildFAQItem(
                question:
                    'Are the products on your website exactly what I will receive?',
                answer:
                    'Yes, we ensure that the products you see on our website are exactly what you receive. Our team takes great care in providing accurate images and descriptions of each item. Please note that slight color variations may occur due to lighting and display differences.',
              ),
              SizedBox(
                height: 20,
              ),
              _buildFAQItem(
                question: 'How can I view or download my sales receipt?',
                answer:
                    'You can view and download your sales receipt in the order confirmation email we send after your purchase. Additionally, you can log in to your ZRJ Fashion account and access your order history to view past purchases and receipts.',
              ),
              SizedBox(
                height: 20,
              ),
              _buildFAQItem(
                question: 'How do I return an item?',
                answer:
                    'To return an item, simply visit our Returns page and follow the step-by-step instructions. Ensure that the item is in its original condition with tags attached, and we’ll guide you through the return or exchange process. For more details on our return policy, please check our Returns page.',
              ),
              SizedBox(
                height: 20,
              ),
              _buildFAQItem(
                question: 'Do you restock popular items?',
                answer:
                    'Yes, we often restock popular items. If an item is out of stock, you can sign up for notifications on the product page, and we’ll alert you once it’s available again. Alternatively, keep checking back for updates on new stock.',
              ),
              SizedBox(
                height: 20,
              ),
              _buildFAQItem(
                question: 'Do you offer worldwide shipping?',
                answer:
                    'We offer worldwide shipping! Your order can be shipped to most countries. During the checkout process, you\'ll have the option to select your location and see the shipping rates and options available to you.',
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Helper method for FAQ Item
  Widget _buildFAQItem({required String question, required String answer}) {
    bool _isExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _isExpanded ? kprimaryColor : Colors.black,
            ),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answer,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }
}

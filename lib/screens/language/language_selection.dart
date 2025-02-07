import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'EN'; // Default language

  void _changeLanguage(String? language) {
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: selectedLanguage,
          icon: Icon(Icons.arrow_drop_up, color: Colors.black),
          onChanged: _changeLanguage,
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Row(
                children: [
                  Image.asset('assets/images/en(2).png', width: 28),
                  SizedBox(width: 8),
                  Text(
                    "EN",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'fr',
              child: Row(
                children: [
                  Image.asset('assets/images/en(1).png', width: 28),
                  SizedBox(width: 8),
                  Text("French"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

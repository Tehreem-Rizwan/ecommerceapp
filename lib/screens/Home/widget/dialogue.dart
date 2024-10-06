import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogue extends StatelessWidget {
  final String? title;
  Dialogue({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title!), actions: [
      OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("CLOSE"))
    ]);
  }
}

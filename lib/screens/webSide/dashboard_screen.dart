import 'package:flutter/cupertino.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});
  static const String id = "dashboard";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("DASHBOARD"),
      ),
    );
  }
}

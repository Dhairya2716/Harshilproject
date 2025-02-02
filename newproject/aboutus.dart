import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us'), backgroundColor: Colors.orange),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "This is a simple user management app built with Flutter.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() {
  runApp(UserManagementApp());
}

class UserManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

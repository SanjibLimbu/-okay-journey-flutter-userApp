import 'package:flutter/material.dart';
import 'package:user_app/screens/home_screen.dart';

void main() {
  runApp(const UserApp());
}


class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

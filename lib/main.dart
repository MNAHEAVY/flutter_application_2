import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeliCoins',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 89, 3, 238)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

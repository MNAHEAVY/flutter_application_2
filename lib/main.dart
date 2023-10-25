import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

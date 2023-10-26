import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/footer.dart';
import 'package:flutter_application_2/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeliCoins',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 89, 3, 238),
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Stack(
          children: <Widget>[
            HomeScreen(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FooterWidget(), // Agrega tu widget estilo footer aquí
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/nft.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            color: Colors.white,
            onPressed: () {
              // Aquí puedes añadir la lógica para el botón de signo $
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            color: Colors.white,
            onPressed: () {
              // Aquí puedes añadir la lógica para el botón de home
            },
          ),
          IconButton(
            icon: const Icon(Icons.nfc),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NFTListView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

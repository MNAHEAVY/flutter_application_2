import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinDetailScreen extends StatefulWidget {
  final String coinId;

  const CoinDetailScreen({Key? key, required this.coinId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  late Coin coin;

  @override
  void initState() {
    super.initState();
    fetchCoinDetails();
  }

  Future<void> fetchCoinDetails() async {
    final coinId = widget.coinId;
    final response = await http
        .get(Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coinData = data;

      setState(() {
        coin = Coin(
          image: coinData['image']['large'],
          name: coinData['name'],
          symbol: coinData['symbol'],
          id: coinData['id'],
        );
      });
    } else {
      print(
          'Failed to fetch coin details. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (coin == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detalle de la moneda',
            style: TextStyle(
              color: Colors.white, // Color del texto (blanco)
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          centerTitle: true, // Centra el título
          backgroundColor:
              Color.fromARGB(255, 42, 181, 155), // Color de fondo (azul)
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles de la Moneda'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Imagen de la moneda
              Image.network(coin.image),
              // Nombre de la moneda
              Text(coin.name, style: const TextStyle(fontSize: 20)),
              // Símbolo de la moneda
              Text(coin.symbol,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }
  }
}

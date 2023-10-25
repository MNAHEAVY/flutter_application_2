import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Coin {
  final String id;
  final String symbol;
  final String name;

  Coin({required this.id, required this.symbol, required this.name});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Coin> coins = [];

  @override
  void initState() {
    super.initState();
    fetchAndLoadData();
  }

  void fetchAndLoadData() async {
    final response = await http
        .get(Uri.parse('https://api.coingecko.com/api/v3/coins/list'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final coinList = data.map((coinData) {
        return Coin(
          id: coinData['id'],
          symbol: coinData['symbol'],
          name: coinData['name'],
        );
      }).toList();

      setState(() {
        coins = coinList;
      });
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeliCoins'),
      ),
      body: ListView.builder(
        itemCount: coins.length,
        itemBuilder: (context, index) {
          final coin = coins[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(coin
                  .imageUrl), // Reemplaza con la URL de la imagen de tu moneda
            ),
            title: Text(coin.name),
            subtitle: Text(coin.symbol),
          );
        },
      ),
    );
  }
}

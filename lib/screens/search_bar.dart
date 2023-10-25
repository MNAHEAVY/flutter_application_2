import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBar extends StatefulWidget {
  final Function(List<Coin>) onSearchResult;

  const SearchBar({Key? key, required this.onSearchResult}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  void _searchCoins(String query) async {
    final response = await http
        .get(Uri.parse('https://api.coingecko.com/api/v3/search?query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coinList = (data['coins'] as List).map((coinData) {
        return Coin(
            image: coinData['item']['large'],
            name: coinData['item']['name'],
            symbol: coinData['item']['symbol'],
            id: coinData['id']);
      }).toList();

      widget.onSearchResult(coinList);
    } else {
      print(
          'Failed to fetch search results. Status code: ${response.statusCode}');
      widget.onSearchResult([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(labelText: 'Buscar Monedas'),
        ),
        ElevatedButton(
          onPressed: () {
            final query = _searchController.text;
            _searchCoins(query);
          },
          child: const Text('Buscar'),
        ),
      ],
    );
  }
}

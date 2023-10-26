import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NFT {
  final String id;
  final String contractAddress;
  final String name;
  final String assetPlatformId;
  final String symbol;

  NFT({
    required this.id,
    required this.contractAddress,
    required this.name,
    required this.assetPlatformId,
    required this.symbol,
  });

  factory NFT.fromJson(Map<String, dynamic> json) {
    return NFT(
      id: json['id'] ?? '',
      contractAddress: json['contract_address'] ?? '',
      name: json['name'] ?? '',
      assetPlatformId: json['asset_platform_id'] ?? '',
      symbol: json['symbol'] ?? '',
    );
  }
}

class NFTService {
  static Future<List<NFT>> getNFTs() async {
    final response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/nfts/list?per_page=100&page=1'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NFT.fromJson(json)).toList();
    } else {
      throw Exception('No se pudieron cargar los NFTs');
    }
  }
}

class NFTListView extends StatelessWidget {
  const NFTListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFTs'),
      ),
      body: FutureBuilder<List<NFT>>(
        future: NFTService.getNFTs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final nfts = snapshot.data;
            return ListView.builder(
              itemCount: nfts?.length ?? 0, // Add null check here
              itemBuilder: (context, index) {
                final nft = nfts?[index];
                if (nft != null) {
                  // Check if nft is not null
                  return ListTile(
                    title: Text(nft.name),
                    subtitle: Text(
                        'Contract: ${nft.contractAddress}, Platform: ${nft.assetPlatformId}'),
                  );
                } else {
                  // Handle the case where nft is null, if necessary.
                  return const SizedBox(); // or any other widget or message
                }
              },
            );
          }
        },
      ),
    );
  }
}

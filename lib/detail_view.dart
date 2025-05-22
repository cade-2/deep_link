import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  void _shareItem() {
    final deepLink = 'https://staging.visit77.com/blog/$id';
    Share.share('Check out this item: $deepLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail $id'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareItem,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details for $id',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            const Text('This is the detailed view of the item.'),
          ],
        ),
      ),
    );
  }
}

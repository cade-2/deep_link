import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final itemId = 'item_$index';
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              context.go('/home/blog/$itemId');
            },
          );
        },
      ),
    );
  }
}

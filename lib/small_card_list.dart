import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotlist/item_bloc.dart';
import 'package:hotlist/large_card_list.dart';

class SmallCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Small Cards')),
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(item.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LargeCardList(startIndex: index),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

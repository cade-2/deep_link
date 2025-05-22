import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class Item {
  final int id;
  final String title;
  final String description;

  Item({required this.id, required this.title, required this.description});
}

class ItemState extends Equatable {
  final List<Item> items;

  ItemState(this.items);

  @override
  List<Object> get props => [items];
}

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemState(_generateItems()));

  static List<Item> _generateItems() {
    return List.generate(
      300,
      (index) => Item(
          id: index,
          title: 'Item $index',
          description: 'Description for Item $index'),
    );
  }
}

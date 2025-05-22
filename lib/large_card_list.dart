// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotlist/item_bloc.dart';

// class LargeCardList extends StatefulWidget {
//   final int startIndex;
//   LargeCardList({required this.startIndex});

//   @override
//   _LargeCardListState createState() => _LargeCardListState();
// }

// class _LargeCardListState extends State<LargeCardList> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.startIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Large Cards')),
//       body: BlocBuilder<ItemCubit, ItemState>(
//         builder: (context, state) {
//           return PageView.builder(
//             controller: _pageController,
//             scrollDirection: Axis.vertical, // Enables up/down scroll
//             itemCount: state.items.length,
//             itemBuilder: (context, index) {
//               final item = state.items[index];
//               return Center(
//                 child: Container(
//                   height: 500,
//                   child: Card(
//                     margin: EdgeInsets.all(16),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(item.title,
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 10),
//                           Text(item.description,
//                               style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotlist/item_bloc.dart';

class LargeCardList extends StatefulWidget {
  final int startIndex;
  LargeCardList({required this.startIndex});

  @override
  _LargeCardListState createState() => _LargeCardListState();
}

class _LargeCardListState extends State<LargeCardList> {
  late ScrollController _scrollController;
  final Map<int, GlobalKey> _keys = {}; // To store GlobalKeys for each item

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Scroll to the selected index after widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(widget.startIndex);
    });
  }

  // Scroll to the specific index using GlobalKey position
  void _scrollToIndex(int index) {
    final key = _keys[index];
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dy;
        _scrollController.animateTo(position,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Large Cards')),
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              final key = GlobalKey(); // Create a unique key for each card
              _keys[index] = key; // Store the key for later use

              return Center(
                child: Container(
                  key: key,
                  margin: EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item.title,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text(item.description,
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotlist/item_bloc.dart';

// class LargeCardList extends StatefulWidget {
//   final int startIndex;
//   LargeCardList({required this.startIndex});

//   @override
//   _LargeCardListState createState() => _LargeCardListState();
// }

// class _LargeCardListState extends State<LargeCardList> {
//   late ScrollController _scrollController;
//   final double cardHeight = 500; // Each card's height
//   final double spacing = 10; // Space between cards

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();

//     /// Ensure UI is built first, then scroll to correct position
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         double targetOffset = widget.startIndex * (cardHeight + spacing);
//         debugPrint("Scrolling to offset: $targetOffset");
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Large Cards')),
//       body: BlocBuilder<ItemCubit, ItemState>(
//         builder: (context, state) {
//           return ListView.builder(
//             controller: _scrollController,
//             itemCount: state.items.length,
//             itemBuilder: (context, index) {
//               final item = state.items[index];

//               return Padding(
//                 padding:
//                     EdgeInsets.symmetric(vertical: spacing / 2, horizontal: 10),
//                 child: Card(
//                   elevation: 4,
//                   child: Container(
//                     height: cardHeight, // Fixed height
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Index: $index - ${item.title}",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           item.description,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

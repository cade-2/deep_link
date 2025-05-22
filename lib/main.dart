// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotlist/item_bloc.dart';
// // import 'package:hotlist/small_card_list.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => ItemCubit(),
// //       child: MaterialApp(
// //         home: SmallCardList(),
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: sort_child_properties_last

// import 'package:flutter/material.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:shimmer/shimmer.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Scroll To Index Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Scroll To Index Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final scrollDirection = Axis.vertical;
//   late AutoScrollController controller;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     controller = AutoScrollController(
//       viewportBoundaryGetter: () =>
//           Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//       axis: scrollDirection,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView(
//         scrollDirection: scrollDirection,
//         controller: controller,
//         children: <Widget>[
//           ...List.generate(500, (index) {
//             return AutoScrollTag(
//               key: ValueKey(index),
//               controller: controller,
//               index: index,
//               child: isLoading
//                   ? _buildShimmerEffect()
//                   : Container(
//                       height: 100,
//                       color: Colors.red,
//                       margin: const EdgeInsets.all(10),
//                       child: Center(child: Text('index: $index')),
//                     ),
//               highlightColor: Colors.black.withOpacity(0.1),
//             );
//           }),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _startLoadingAndScroll,
//         tooltip: 'Scroll',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildShimmerEffect() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: 100,
//         margin: const EdgeInsets.all(10),
//         color: Colors.white,
//       ),
//     );
//   }

//   Future _startLoadingAndScroll() async {
//     setState(() {
//       isLoading = true;
//     });

//     // Simulating data loading delay
//     await Future.delayed(const Duration(seconds: 2));

//     // Scroll to index after loading
//     await controller.scrollToIndex(400,
//         preferPosition: AutoScrollPosition.begin);
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:hotlist/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks;
  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks(); // ✅ Correct initialization
    _initAppLinks();
  }

  Future<void> _initAppLinks() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null &&
          initialUri.host == 'staging.visit77.com' &&
          initialUri.path.startsWith('/blog')) {
        final id = initialUri.pathSegments.length > 1
            ? initialUri.pathSegments[1]
            : '';
        goRouter.go('/home/blog/$id');
      }
    } catch (e) {
      debugPrint('Error handling initial App Link: $e');
    }

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null &&
          uri.host == 'staging.visit77.com' &&
          uri.path.startsWith('/blog')) {
        final id = uri.pathSegments.length > 1 ? uri.pathSegments[1] : '';
        goRouter.go('/home/blog/$id');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Link Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

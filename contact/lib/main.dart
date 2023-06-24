import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Row(
          mainAxisAlignment : MainAxisAlignment.spaceEvenly
         children: [
          Icon(Icons.star),
          Icon(Icons.star)
         ],
        ),
        bottomNavigationBar: BottomAppBar(child: Text('메뉴'))
      )
    );
  }
}

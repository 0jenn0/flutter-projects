import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      iconTheme: IconThemeData(color: Colors.blue),
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.grey, size: 30),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
          )),
    ),
  ));
}

var fontStyle = TextStyle();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Instagram',
          ),
        ),
        actions: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.add_box_outlined))
        ],
      ),
      body: Icon(Icons.star),
    );
  }
}

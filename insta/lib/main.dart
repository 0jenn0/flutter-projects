import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: MyApp(), theme: style.theme));
}

var fontStyle = TextStyle();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'))
        .then((value) => jsonDecode(value.body));
    print(result[0]['likes']);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
          IconButton(onPressed: () {}, icon: Icon(Icons.add_box_outlined))
        ],
      ),
      body: [Home(), Text('Shop')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          print(i);
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'shop')
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (c, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(),
              Text('좋아요 100'),
              Text('글쓴이'),
              Text('글내용'),
            ],
          );
        },
        itemCount: 3);
  }
}

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
  var data = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'))
        .then((value) => jsonDecode(value.body));
    setState(() {
      data = result;
    });
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
      body: [Home(data: data), Text('Shop')][tab],
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

class Home extends StatelessWidget {
  const Home({super.key, this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (c, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(data[i]['image']),
              Text('likes ' + data[i]['likes'].toString()),
              Text(data[i]['user']),
              Text(data[i]['content'])
              // Text(data[0]['content'])
            ],
          );
        });
  }
}

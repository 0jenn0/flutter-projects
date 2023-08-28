import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart'; // 스크롤 다룰 때 임포트해놓고 시작하면 좋음

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

  addData(String url) async {
    var result =
        await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
    setState(() {
      data.add(result);
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
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => Upload()));
              },
              icon: Icon(Icons.add_box_outlined))
        ],
      ),
      body: [Home(data: data, addData: addData), Text('Shop')][tab],
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
  const Home({super.key, this.data, this.addData});
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() async {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        widget.addData('https://codingapple1.github.io/app/more1.json');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          controller: scroll,
          itemCount: widget.data.length,
          itemBuilder: (c, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.data[i]['image']),
                Text('likes ${widget.data[i]['likes']}'),
                Text(widget.data[i]['user']),
                Text(widget.data[i]['content'])
                // Text(data[0]['content'])
              ],
            );
          });
    } else {
      return Text('Loading ...');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이미지 업로드 화면'),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ));
  }
}

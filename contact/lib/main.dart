import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> data = [
    {'name': '하니', 'likes': 0},
    {'name': '다니엘', 'likes': 0},
    {'name': '해린', 'likes': 0}
  ];
  void _incrementLike(int index) {
    setState(() {
      data[index]['likes'] += 1;
      // data = deepCopyData(data);
    });
  }

  List<Map<String, dynamic>> deepCopyData(
      List<Map<String, dynamic>> originalData) {
    return originalData.map((item) {
      return Map<String, dynamic>.from(item);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Contact',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          TextButton(onPressed: () {}, child: Text('Ok'))
                        ],
                      )
                    ],
                  ),
                ));
              });
        }),
        appBar: AppBar(
          title: Row(
            children: [
              Text('연락처앱'),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.keyboard_arrow_down),
                color: Colors.black,
              )
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                )),
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.black,
            size: 25,
          ),
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (c, i) {
              return ListTile(
                leading: Text(data[i]['likes'].toString()),
                title: Text(data[i]['name'].toString()),
                trailing: TextButton(
                  child: Text('좋아요'),
                  onPressed: () {
                    _incrementLike(i);
                  },
                ),
              );
            }),
        bottomNavigationBar: BottomBar());
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.phone),
          Icon(Icons.message),
          Icon(Icons.contact_page)
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = ['하니', '다니엘', '해린'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    a++;
                  });
                },
                child: Text(a.toString())),
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
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
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
                      leading: Image.asset('assets/img.jpg'),
                      title: Text(name[i]));
                }),
            bottomNavigationBar: BottomBar()));
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

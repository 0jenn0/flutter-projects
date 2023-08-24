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
            appBar: AppBar(
              title: Row(
                children: [
                  Text('금호동3가'),
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
            body: ShopItem(),
            bottomNavigationBar: BottomAppBar(
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
            ))));
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset('assets/img.jpg', fit: BoxFit.fill),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                      text: '캐논 DSLR 100D (단렌즈,충전기 16기가SD 포함,흥정 불가능)',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '성동구 행당동 끌올 10분 전',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '210,000원',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                      iconSize: 20,
                    ),
                    Text('3')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

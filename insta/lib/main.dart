import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/notification.dart';
import 'package:provider/provider.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart'; // 스크롤 다룰 때 임포트해놓고 시작하면 좋음
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//       create: (c) => Store1(),
//       child: MaterialApp(home: MyApp(), theme: style.theme)));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (c) => Store1()),
    ChangeNotifierProvider(create: (c) => Store2()),
  ], child: MaterialApp(home: MyApp(), theme: style.theme)));
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
  var userImage;

  saveData() async {
    // 저장 공간 오픈하는 법
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'john');
    // storage.remove('name'); 내용 삭제
    // var result = storage.get('name');
    var map = {'age': 20};
    storage.setString('map', jsonEncode(map)); // map을 JSON으로 바꿔줌.
    var result = storage.getString('map') ?? '없음';
    print(jsonDecode(result)['age']);
  }

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

  upload(String text, File url) {
    setState(() {
      data.insert(0,
          {'image': url, 'content': text, 'user': 'nyamnyam.good', 'likes': 0});
    });
  }

  Future<void> _pickImageAndNavigate(BuildContext initialContext) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final userImage = File(image.path);
      Navigator.push(
          initialContext,
          MaterialPageRoute(
              builder: (c) => Upload(userImage: userImage, upload: upload)));
    }
  }

  @override
  void initState() {
    super.initState();
    initNotification(context);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNotification();
        },
        child: Text('+'),
      ),
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
                _pickImageAndNavigate(context);
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
                // Image.network(widget.data[i]['image']),
                widget.data[i]['image'].runtimeType == String
                    ? Image.network(widget.data[i]['image'])
                    : Image.file(widget.data[i]['image']),
                Text('likes ${widget.data[i]['likes']}'),
                GestureDetector(
                  child: Text(widget.data[i]['user']),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => Profile(),
                            transitionsBuilder: (c, a1, a2, child) =>
                                FadeTransition(
                                  opacity: a1,
                                  child: child,
                                ),
                            transitionDuration: Duration(milliseconds: 50)));
                  },
                ),
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
  Upload({super.key, this.userImage, this.upload});
  final userImage;
  final upload;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  upload(inputData.text, userImage);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.send))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),
            Text('이미지 업로드 화면'),
            TextField(
              controller: inputData,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ));
  }
}

class Store1 extends ChangeNotifier {
  var follower = 0;
  var isFollow = false;
  var profileImage = [];

  follow() {
    isFollow ? follower -= 1 : follower += 1;
    isFollow = !isFollow;
    notifyListeners();
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'))
        .then((value) => jsonDecode(value.body));
    profileImage = result;
    print(result[0]);
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier {
  var name = 'john kim';
  changeName(newName) {
    name = newName;
    notifyListeners(); // 재랜더링
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Store1>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        // slivers 안에 있는거 합쳐서 스크롤바 하나 만들어줌.
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage:
                        NetworkImage(context.watch<Store1>().profileImage[0])),
                Text(context.watch<Store2>().name),
                Text('팔로워 ${context.watch<Store1>().follower}명'),
                TextButton(
                    onPressed: () {
                      context.read<Store1>().follow();
                    },
                    child: Text("팔로우"))
              ],
            ),
          ),
          // Expanded(
          //   child: GridView.builder(
          //     padding: EdgeInsets.all(10),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 3), // 몇 개를 가로로 보여줄지
          //     itemBuilder: (c, i) {
          //       return Container(
          //         color: Colors.lightGreen,
          //       );
          //     },
          //     itemCount: 3,
          //   ),
          // )
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (c, i) =>
                      Image.network(context.watch<Store1>().profileImage[i]),
                  childCount: 5),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
        ],
      ),
    );
  }
}

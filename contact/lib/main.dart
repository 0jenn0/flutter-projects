import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      print(contacts[0].displayName);

      // // 연락처 추가하기
      // var newPerson = Contact();
      // newPerson.givenName = '굿';
      // newPerson.familyName = '냠냠';
      // await ContactsService.addContact(newPerson);

      data = contacts;

      print(contacts[0].phones);
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
      // openAppSettings();
    }
  }

  Future<bool> addPerson(String givenNameData, String familyNameData) async {
    print('$givenNameData $familyNameData');

    var newPerson = Contact(
        givenName: givenNameData.toString(),
        familyName: familyNameData.toString(),
        displayName: '$givenNameData $familyNameData');

    print(newPerson.displayName);

    await ContactsService.addContact(newPerson);

    setState(() {
      data.add(newPerson);
    });

    return true;
  }

  // List<Map<String, dynamic>> data = [
  //   {'name': '하니', 'likes': 0},
  //   {'name': '다니엘', 'likes': 0},
  //   {'name': '해린', 'likes': 0}
  // ];

  List<Contact> data = [];
  // late int num;

  // @override
  // void initState() {
  //   // num = data.length;
  //   super.initState();
  //   getPermission();
  // }

  // addOne() {
  //   setState(() {
  //     num += 1;
  //   });
  // }

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
                return DialogUI(
                  // addOne: addOne,
                  addPerson: addPerson,
                );
              });
        }),
        appBar: AppBar(
          title: Row(
            children: [
              Text('연락처'),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          actions: [
            IconButton(
                onPressed: () {
                  getPermission();
                },
                icon: Icon(
                  Icons.contacts,
                )),
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.black,
            size: 25,
          ),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (c, i) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(data[i].displayName.toString()),
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

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addOne, this.addPerson});
  final addOne;
  final addPerson;
  var givenNameData = TextEditingController();
  var familyNameData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: EdgeInsets.all(20),
      height: 400,
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
          Column(
            children: [
              TextField(
                controller: givenNameData,
              ),
              TextField(
                controller: familyNameData,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    addPerson(givenNameData.text.toString(),
                        familyNameData.text.toString());
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          )
        ],
      ),
    ));
  }
}

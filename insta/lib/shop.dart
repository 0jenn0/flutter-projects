import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    // var result =
    //     await firestore.collection('product').doc('ErbR3exKr11CIVhGqbP4').get();
    try {
      //추가하기
      await firestore.collection('product').add({'name': '내복', 'price': 5000});
      // await firestore.collection('produc').doc().delete();
      // await firestore.collection('produc').doc().update({'name':'헌내복'});
      var result = await firestore.collection('product').get();
      for (var doc in result.docs) {
        print(doc['name']);
      }
    } catch (e) {
      print('데이터를 가져오지 못함');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임!'),
    );
  }
}

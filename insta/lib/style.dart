import 'package:flutter/material.dart';

var theme = ThemeData(
  // textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(backgroundColor: Colors.blue)),
  iconTheme: IconThemeData(color: Colors.blue),
  appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.grey, size: 30),
      backgroundColor: Colors.white,
      elevation: 1, // 그림자 크기
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
      )),
);

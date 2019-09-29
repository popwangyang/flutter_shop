import 'package:flutter/material.dart';
import 'pags/index_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,  // 去除app右上角的debug；
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
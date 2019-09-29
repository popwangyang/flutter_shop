
import 'package:flutter/material.dart';
import '../api/home.api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String homePageContent = '正在获取数据';

  @override
  void initState() {
    Map<String, dynamic> sendData = {
      'page': 1,
      'page_size': 1,
    };
    getData(sendData).then((val) {
      print(val);
      setState(() {
        homePageContent = val.toString();
      });
    }).catchError((error){
      print(error);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('菜谱大全'),
      ),
      body: Text(homePageContent),
    );
  }
}

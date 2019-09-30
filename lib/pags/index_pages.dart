import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'huyuan_page.dart';
import 'search_page.dart';
import 'shop_page.dart';

class IndexPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndexPageState();
  }
}


class _IndexPageState extends State<IndexPage>{

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text("搜索")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text("购物车")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text("会员中心")
    ),
  ];

  final List pages = [
    HomePage(),
    HuyanPage(),
    SearchPage(),
    ShopPage(),
  ];

  int currentIndex = 0;

  var currentPage;

  @override
  void initState() {
    currentIndex = 0;
    currentPage = pages[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
         items: bottomTabs,
         type: BottomNavigationBarType.fixed,
         currentIndex: currentIndex,
         onTap: (index){
           setState(() {
             currentIndex = index;
             currentPage = pages[currentIndex];
           });
         },
      ),
      body: currentPage,
    );
  }
}
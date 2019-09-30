
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/home.api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setHeight(320),
              child: Swiper(
                itemBuilder: (BuildContext context, int index){
                  return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
                },
                itemCount: 3,
                pagination: SwiperPagination(),
                control: SwiperControl(),
              ),
            )
          ],
        ),
      ),
    );
  }

}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/home.api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive =>true;

   List swipeData = [];
   List navData = [];
   String banner;
   Map shopperPhone;
   List recommendList = [];

   Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot){
     switch(snapshot.connectionState){
       case ConnectionState.none:
         return Text("还没开始请求");
       case ConnectionState.active:
         return Text("开始请求");
       case ConnectionState.waiting:
         return Center(
           child: Text('加载中......'),
         );
       case ConnectionState.done:
         if(snapshot.hasError){
           return Text('Error: ${snapshot.error}');
         }
         return _createListView(context, snapshot);
       default:
         return Text('还没有开始网络请求');
     }
   }

   Widget _createListView(BuildContext context, AsyncSnapshot snapshot){

     swipeData = snapshot.data['swipeData'];
     navData = snapshot.data['navData'];
     banner = snapshot.data['bannerData']['imgUrl'];
     shopperPhone = snapshot.data['bannerData']['shopowner'];
     recommendList = snapshot.data['recommend'];

     print('pp');

     return
       SingleChildScrollView(// Optional
       child: Container(
         child: Column(
           children: <Widget>[
             SwiperBox(swipeList: swipeData,),
             NavigationBox(navigationList: navData,),
             BannerBox(imgUrl: banner,),
             ShopOwnerPhone(data: shopperPhone,),
             RecommendList(recommendList: recommendList,),

           ],
         ),
       ),
       );
   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: getHomeData(),
        builder: _buildFuture,

      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }
}

// 轮播图
class SwiperBox extends StatelessWidget {

  final List swipeList;
  SwiperBox({Key key, this.swipeList}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(360),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return new Image.asset(swipeList[index]['url'],fit: BoxFit.fill,);
        },
        itemCount: swipeList.length,
        pagination: SwiperPagination(),
//        control: SwiperControl(),
        autoplay: true,
      ),
    );
  }
}


// 首页nav部分
class NavigationBox extends StatelessWidget {

  final List navigationList;

  NavigationBox({Key key, this.navigationList}): super(key: key);

  Widget _gradViewItemUI(BuildContext context, item){
    return Container(
      child: InkWell(
        child: Column(
          children: <Widget>[
            Image.asset(
              item.url,
              width: ScreenUtil.getInstance().setWidth(80),
              height: ScreenUtil.getInstance().setHeight(80),
            ),
            Text(item.name)
          ],
        ),
        onTap: (){
          print(item.name);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 6,right: 6, top: 10, bottom: 10),
      height: ScreenUtil.getInstance().setHeight(260.0),
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          children: navigationList.map((item){
            return _gradViewItemUI(context, item);
          }).toList(),
      ),
    );
  }
}


// 广告banner
class BannerBox extends StatelessWidget {

  BannerBox({Key key, this.imgUrl}): super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return
       InkWell(
         child: Container(
           color: Colors.red,
           margin: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
           height: ScreenUtil.getInstance().setHeight(80),
           child: Image.asset(imgUrl, fit: BoxFit.fitWidth,),
         ),
         onTap: (){
           print('banner');
         },
       )
      ;
  }
}


//店长电话
class ShopOwnerPhone extends StatelessWidget {

  final Map data;
  ShopOwnerPhone({Key key, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(6.0, 10, 6.0, 10),
        height: ScreenUtil.getInstance().setHeight(200),
        child: Image.asset(data['url'], fit: BoxFit.fitWidth,),
      ),
      onTap: _launchURL,
    );
  }

  void _launchURL() async {
    String url = 'tel:'+data['phone'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐
class RecommendList extends StatelessWidget {
  
  final List recommendList;
  
  RecommendList({Key key, this.recommendList}): super(key: key);
  
  // 商品title
  Widget _title(){
    return Container(
      height: ScreenUtil.getInstance().setHeight(60),
      alignment: Alignment.centerLeft,
      child: Text('商品推荐', style: TextStyle(
        color: Colors.red,
      ),),
    );
  }

  // 商品详情
  Widget _goods(data){
    return Container(
      height: ScreenUtil.getInstance().setHeight(330),
      width: ScreenUtil.getInstance().setWidth(250),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Image.asset(data['goodsUrl']),
          ),
          Text('￥${data['price1']}'),
          Text('￥${data['price2']}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black12
          ),)
        ],
      ),
    );
  }
  // 商品列表
  Widget _goodList(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: recommendList.map((item){
          return _goods(item);
        }).toList(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(410),
      padding: EdgeInsets.only(left: 6.0, right: 6.0),
      child: Column(
        children: <Widget>[
          _title(),
          _goodList(),
        ],
      ),
    );
  }
}

// 

//火爆专区
class HotArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



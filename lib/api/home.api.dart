import 'package:dio/dio.dart';

import 'api.request.dart';

Future<Response> getData(){
//  print(params);

  return ajax.request(
      '/wxmini/homePageContent',
      options: Options(method: 'get'),
  );
}

Future<List> getSwipe(){
  return Future.delayed(Duration(seconds: 1),(){
    return [
        {
        'url': 'lib/assets/swipe1.jpg'
        },
        {
        'url': 'lib/assets/swipe3.jpg'
        }
    ];
  });
}

class NavDataItem{
  String url;
  String name;

  String _path = 'lib/assets/';

  NavDataItem(url, name){
    this.url = _path+url;
    this.name = name;
  }
}

Future<List> getNavData(){
  return Future.delayed(Duration(seconds: 1),(){
    return [
      NavDataItem('nav1.png', '保龄球'),
      NavDataItem('nav2.png', '力士轮胎'),
      NavDataItem('nav3.png', '奖杯'),
      NavDataItem('nav4.png', '帆船'),
      NavDataItem('nav5.png', '急救箱'),
      NavDataItem('nav6.png', '标靶'),
      NavDataItem('nav7.png', '橄榄球'),
      NavDataItem('nav8.png', '滑板'),
      NavDataItem('nav9.png', '路标'),
      NavDataItem('nav10.png', '驾驶'),
    ];
  });
}

Future<Map> getBannerData(){
  return Future.delayed(Duration(seconds: 1), (){
    return {
      'imgUrl':'lib/assets/banner.jpg',
      'shopowner': {
        'url': 'lib/assets/shopownerPhone.jpg',
        'phone': '010-87655210'
      }
    };
  });
}

Future<List> getRecommendData(){
  return Future.delayed(Duration(seconds: 1), (){
    return [
      {
        'goodsUrl': 'lib/assets/recommendGoods1.jpg',
        'price1': '200.00',
        'price2': '300.00'
      },
      {
        'goodsUrl': 'lib/assets/recommendGoods2.jpg',
        'price1': '200.00',
        'price2': '300.00'
      },
      {
        'goodsUrl': 'lib/assets/recommendGoods3.jpg',
        'price1': '200.00',
        'price2': '300.00'
      },
      {
        'goodsUrl': 'lib/assets/recommendGoods4.jpg',
        'price1': '200.00',
        'price2': '300.00'
      }
    ];
  });
}

Future getHomeData(){
  return Future.wait([getSwipe(), getNavData(),getBannerData(), getRecommendData()]).then((val){
    Map result = {
      'swipeData': val[0],
      'navData': val[1],
      'bannerData': val[2],
      'recommend': val[3]
    };
    return result;
  });

}
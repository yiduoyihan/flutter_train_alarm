import 'dart:async';

import 'package:f_train_alarm/map/basic_map.dart';
import 'package:f_train_alarm/map/map_base_page_state.dart';
import 'package:f_train_alarm/pages/alarm/HistoryAlarmPage.dart';
import 'package:f_train_alarm/pages/alarm/SearchTrackPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_controller.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_view.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_map_options.dart';
///要导这个不然找不到BMFCoordinate类
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_userlocation.dart';


class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends BMFBaseMapState<AlarmPage> {
  /// 定位模式状态
  bool _showUserLocaion = true;
  /// 我的位置
  BMFUserLocation _userLocation;
  /// 定位模式
  BMFUserTrackingMode _userTrackingMode = BMFUserTrackingMode.Follow;

  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();
  BaiduLocation _baiduLocation; // 定位结果
  StreamSubscription<Map<String, Object>> _locationListener;
  Map<String, Object> _loationResult;

  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 18,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));


  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 地图加载回调
    myMapController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');

      if (_showUserLocaion) {
        myMapController?.showUserLocation(true);
        myMapController?.setUserTrackingMode(_userTrackingMode);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    _startLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text("告警"),
        centerTitle: true,
        leading: IconButton(
            icon: Image(
                height: 25,
                width: 25,
                image: AssetImage('assets/images/alarm_left.png')),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryAlarmPage()));
            }),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
              icon: Image(
                  height: 25,
                  width: 25,
                  image: AssetImage('assets/images/alarm_right.png')),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchTrackPage()));
              }),
        ],
      ),
      body: Container(
        height:double.infinity,
        width:double.infinity,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: mapOptions,
        ),
      ),
      // body:  BasicMap(),
    );
  }


  /// 启动定位
  void _startLocation() {
    if (null != _locationPlugin) {
      _setLocOption();
      _locationPlugin.startLocation();
    }
  }

  /// 停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (null != _locationListener) {
      _locationListener.cancel(); // 停止定位
    }
  }

  /// 设置android端和ios端定位参数
  void _setLocOption() {
    /// android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(1000 * 10); // 设置发起定位请求时间间隔

    Map androidMap = androidOption.getMap();

    /// ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  @override
  void initState() {
    super.initState();

    /// 动态申请定位权限
    _locationPlugin.requestPermission();

    /// 设置ios端ak, android端ak可以直接在清单文件中配置
    // LocationFlutterPlugin.setApiKey("百度地图开放平台申请的ios端ak");

    _locationListener =
        _locationPlugin.onResultCallback().listen((Map<String, Object> result) {
          setState(() {
            _loationResult = result;
            try {
              _baiduLocation =
                  BaiduLocation.fromMap(result); // 将原生端返回的定位结果信息存储在定位结果类中

              BMFCoordinate coordinate = BMFCoordinate(_baiduLocation.latitude, _baiduLocation.longitude);
              updateUserLocation(coordinate);
            } catch (e) {
              print(e);
            }
          });
        });
  }

  /// 更新位置
  void updateUserLocation(BMFCoordinate coordinate) {
    // BMFCoordinate coordinate = BMFCoordinate(39.965, 116.404);
    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: 0,
        horizontalAccuracy: 5,
        verticalAccuracy: -1.0,
        speed: -1.0,
        course: -1.0);
    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );
    _userLocation = userLocation;
    myMapController?.updateLocationData(_userLocation);
  }
}


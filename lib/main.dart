import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/Sp.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/model/login/login_bean_entity.dart';
import 'package:f_train_alarm/pages/Application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:toast/toast.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;

import 'api/CommonService.dart';

void main() {
  runApp(MyApp());
  if(Platform.isIOS){
    BMFMapSDK.setApiKeyAndCoordType(
        '请输入百度开放平台申请的iOS端API KEY', BMF_COORD_TYPE.BD09LL);
  }else if(Platform.isAndroid){
// Android 目前不支持接口设置Apikey,
// 请在主工程的Manifest文件里设置，详细配置方法请参考[https://lbsyun.baidu.com/ 官网][https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);}

}

class MyApp extends StatelessWidget {
  String _islogin = "false";

  @override
  Widget build(BuildContext context) {
    _islogin = Sp.getIsLogin();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _islogin == "true"
            ? ApplicationPage()
            : MyHomePage(title: 'Flutter Demo Home Page'));
    // home:ApplicationPage()
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //定义一个controller
  TextEditingController _unameController = TextEditingController();
  TextEditingController _upwdController = TextEditingController();
  Map<String, Object> _loationResult;
  BaiduLocation _baiduLocation; // 定位结果
  StreamSubscription<Map<String, Object>> _locationListener;
  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();
  AndroidDeviceInfo _androidInfo;

  @override
  Widget build(BuildContext context) {
    _startLocation();
    _getDeviceId();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 54, 158, 254),
                Color.fromARGB(255, 43, 110, 240)
              ]), //背景渐变
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 80, 0, 0),
                child: Text("您好！欢迎使用",
                    style: TextStyle(color: Colors.white, fontSize: 32))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 50),
                child: Text(
                  "列车接近告警APP",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextField(
                  controller: _unameController,
                  textAlign: TextAlign.center,
                  //提示文字水平居中
                  textAlignVertical: TextAlignVertical.bottom,
                  //解决文字偏上的问题
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "请输入您的账号",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: _inputBorder(),
                    enabledBorder: _inputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextField(
                  controller: _upwdController,
                  textAlign: TextAlign.center,
                  //提示文字水平居中
                  textAlignVertical: TextAlignVertical.bottom,
                  //解决文字偏上的问题
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  //是否隐藏输入内容，一般用在密码等
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "请输入您的密码",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: _inputBorder(),
                    enabledBorder: _inputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.white,
                  shape: _buttonBorder(),
                  child: Text(
                    "立即使用",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    requestLogin();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //输入框的边框
  _inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
            color: Colors.white, width: 1.0, style: BorderStyle.solid));
  }

  //按钮的事件
  _buttonBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    );
  }

  void requestLogin() {
    //必要参数都不能为空
    if (_unameController.text.length > 0 && _upwdController.text.length > 0) {
      if (_androidInfo != null &&
          _androidInfo.androidId.length > 0 &&
          _baiduLocation != null &&
          _baiduLocation.latitude != null &&
          _baiduLocation.longitude != null) {
        CommonService().login(
            _unameController.text,
            _upwdController.text,
            _androidInfo.androidId,
            _baiduLocation.latitude.toString(),
            _baiduLocation.longitude.toString(), (LoginBeanEntity _bean) {
              if(_bean.code == 200){
                _stopLocation();
                // Sp.putIs
                SpUtil.saveData(GlobalConfig.deviceId, _androidInfo.androidId);
                SpUtil.saveData(GlobalConfig.isLogin, true);
                SpUtil.saveData(GlobalConfig.token, _bean.data.token);
                SpUtil.saveData(GlobalConfig.userId, _bean.data.userInfo.id);
                SpUtil.saveData(GlobalConfig.userFlag, _bean.data.userInfo.roleId);
                SpUtil.saveData(GlobalConfig.pushUrl, _bean.data.mpushServerIp);
                SpUtil.saveData(GlobalConfig.userName, _bean.data.userInfo.userName);
                SpUtil.saveData(GlobalConfig.password, _bean.data.userInfo.password);
                //跳转并关闭当前页面
                Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(builder: (context) => new ApplicationPage()),
                      (route) => route == null,
                );
              }
          print(_bean.msg);
        });
      } else {
        print("缺少必要参数");
      }
    } else {
      Toast.show("用户名密码不能为空", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    // CommonService().login()
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
          print(_baiduLocation.address);
        } catch (e) {
          print(e);
        }
      });
    });
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

  Future<void> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    _androidInfo = await deviceInfo.androidInfo;
    print('Running on ${_androidInfo.androidId}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');
  }
}

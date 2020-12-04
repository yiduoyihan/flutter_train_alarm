import 'dart:async';

import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/pages/setting/AboutOursPage.dart';
import 'package:f_train_alarm/pages/setting/SettingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelfPage extends StatefulWidget {
  @override
  _SelfPageState createState() => _SelfPageState();
}

class _SelfPageState extends State<SelfPage> {
  String string = "用户名";

  @override
  void initState() {
    super.initState();
    SpUtil.getData(GlobalConfig.userName).then((value) {
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          string = value;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("我的"),
        // ),
        //注册路由表
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              width: double.infinity,
              color: GlobalConfig.color_self_top,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 60),
              child: Text(
                "$string",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 100),
              width: double.infinity,
              child: Image(
                image: AssetImage("assets/images/self_fm_top.png"),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AboutOursPage())),
          child: Container(
            margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15),
            padding: EdgeInsets.only(left: 10),
            //容器外填充
            constraints:
                BoxConstraints.tightFor(width: double.infinity, height: 45),
            //卡片大小
            decoration: _selfDecoration(),
            alignment: Alignment.centerLeft,
            //卡片内文字居中
            child: Text(
              //卡片文字
              "关于我们", style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingPage())),
          child: Container(
            margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15),
            padding: EdgeInsets.only(left: 10),
            //容器外填充
            constraints:
                BoxConstraints.tightFor(width: double.infinity, height: 45),
            //卡片大小
            decoration: _selfDecoration(),
            alignment: Alignment.centerLeft,
            //卡片内文字居中
            child: Text(
              //卡片文字
              "设置", style: TextStyle(fontSize: 18.0),
            ),
          ),
        )
      ],
    ));
  }

  _selfDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), //10像素圆角
        color: Colors.white,
        boxShadow: [
          //卡片阴影
          BoxShadow(
              color: Colors.black12, offset: Offset(1.0, 1.0), blurRadius: 4.0)
        ]);
  }
}

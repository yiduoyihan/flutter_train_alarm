import 'dart:async';

import 'package:f_train_alarm/api/CommonService.dart';
import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/main.dart';
import 'package:f_train_alarm/model/login/base_bean_entity.dart';
import 'package:f_train_alarm/pages/setting/ChangePassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context)=> ChangePassword()
                )
            ),
            child: Container(
              margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15),
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
                "修改密码", style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _openChooseDialog(context),
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
                "退出登录", style: TextStyle(fontSize: 18.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  //添加边框圆角和阴影
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

  Future<bool> _openChooseDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要退出APP吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                String _deviceId, _token;
                SpUtil.getData<String>(GlobalConfig.deviceId).then((value) {
                  _deviceId = value;
                });
                SpUtil.getData<String>(GlobalConfig.token).then((value) {
                  _token = value;
                });
                //由于sharedpreference取数据是异步的，所以要等一点时间
                Timer(Duration(milliseconds: 100), () {
                  CommonService().outLogin(_token, _deviceId,
                      (BaseBeanEntity _bean) {
                    if (_bean.code == 200) {
                      SpUtil.cleanData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => MyHomePage()),
                          (route) => route == null);
                    } else {
                      Toast.show("退出失败，请稍后再试", context);
                    }
                  });
                });
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:f_train_alarm/api/CommonService.dart';
import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/model/login/base_bean_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePwd createState() => new _ChangePwd();
}

class _ChangePwd extends State<ChangePassword> {
  //定义一个controller
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _newTwicePwdController = TextEditingController();
  String _deviceId, _token, _userId;

  @override
  void initState() {
    super.initState();
    SpUtil.getData<String>(GlobalConfig.deviceId).then((value) {
      _deviceId = value;
    });
    SpUtil.getData<String>(GlobalConfig.token).then((value) {
      _token = value;
    });
    SpUtil.getData<String>(GlobalConfig.userId).then((value) {
      _userId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: Text("修改密码"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("旧密码："),
            SizedBox(
              height: 10,
            ),
            _inputEditText("请输入旧密码", _oldPwdController),
            SizedBox(
              height: 10,
            ),
            Text("新密码："),
            SizedBox(
              height: 10,
            ),
            _inputEditText("请输入新密码", _newPwdController),
            SizedBox(
              height: 10,
            ),
            Text("确认密码："),
            SizedBox(
              height: 10,
            ),
            _inputEditText("请再次输入新密码", _newTwicePwdController),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                child: Text("确    认"),
                onPressed: () {
                  if (_oldPwdController.text.length > 0 &&
                      _newPwdController.text.length > 0 &&
                      _newTwicePwdController.text.length > 0) {
                    if (_newPwdController.text == _newTwicePwdController.text) {
                      //OJBK 可以提交
                      CommonService().changePwd(
                          _token,
                          _deviceId,
                          _userId,
                          _oldPwdController.text,
                          _newPwdController.text,
                          _newTwicePwdController.text, (BaseBeanEntity _bean) {
                        if (_bean.code == 200) {
                          Toast.show("修改成功", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                        } else {
                          Toast.show("修改失败", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                        }
                      });
                    } else {
                      Toast.show("两次输入的新密码不一致，请检查后重试", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                  } else {
                    Toast.show("必要信息不能为空", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //输入框的边框
  _inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
            color: Colors.white, width: 1.0, style: BorderStyle.solid));
  }

  _inputEditText(String s, TextEditingController oldPwdController) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextField(
        controller: oldPwdController,
        //提示文字水平居中
        textAlignVertical: TextAlignVertical.bottom,
        //解决文字偏上的问题
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: s,
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            filled: true,
            // 设置背景色
            fillColor: Colors.white),
      ),
    );
  }
}

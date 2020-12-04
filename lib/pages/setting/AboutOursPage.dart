import 'package:package_info/package_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 关于我们的页面没什么问题了，后面可以不用动这个页面
// ignore: must_be_immutable
class AboutOursPage extends StatefulWidget {
  @override
  _AboutOurs createState() => new _AboutOurs();
}

class _AboutOurs extends State<AboutOursPage> {
  String _version;

  @override
  Widget build(BuildContext context) {
    _getPackageInfo();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        appBar: AppBar(
          title: Text("关于我们"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(colors:[Colors.red,Colors.orange[700]]), //背景渐变
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0), //圆角
                    boxShadow: [
                      //阴影
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 5.0)
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      width: 60,
                      height: 60,
                      image: AssetImage("assets/images/icon.png"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "版本号：",
                              style: TextStyle(
                                color: Color.fromARGB(255, 88, 88, 88),
                              ),
                            ),
                          ),
                          Text(
                            "$_version",
                            style: TextStyle(
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: SizedBox(
                          height: 1,
                          width: double.infinity,
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        ));
  }

  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //APP名称
    String appName = packageInfo.appName;
    //包名
    String packageName = packageInfo.packageName;
    //版本名
    String version = packageInfo.version;
    //版本号
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      _version = version;
    });
  }
}

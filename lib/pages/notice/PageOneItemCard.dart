import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_train_alarm/model/login/home_list_bean_entity.dart';
import 'package:flutter_html/flutter_html.dart';

///  首页公告的item组成。
class PageOneItemCard extends StatelessWidget {
  final HomeListBeanData data;

  const PageOneItemCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //背景装饰
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0), //3像素圆角
          boxShadow: [
            //卡片阴影
            BoxShadow(
                color: Colors.black38,
                offset: Offset(1.0, 1.0),
                blurRadius: 4.0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Image(
                  image: AssetImage("assets/images/msg_item_icon.png"),
                  width: 20.0,
                  height: 20.0,
                  color: Color(0X452d8cf0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "普通公告",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Text(
                data.createTime,
                style: TextStyle(fontSize: 12, color: Colors.black45),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              data.noticeTitle,
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              data.noticeContent,
              maxLines: 1,
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ),
          Html(data: """${data.noticeContent}"""),
        ],
      ),
    );
  }
}

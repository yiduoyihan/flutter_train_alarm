import 'dart:ui';

import 'package:f_train_alarm/model/login/history_list_data_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  首页公告的item组成。
class HistoryAlarmItemCard extends StatelessWidget {
  final HistoryListDataData data;

  const HistoryAlarmItemCard({
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
        child: Row(
          children: [
            Container(
              width: 40,
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage("assets/images/msg_item_icon.png"),
                width: 20.0,
                height: 20.0,
                color: Color(0X452d8cf0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Text("2021年1月15日10:40:38",textAlign: TextAlign.end,),
                 ],
               ),
                Text("紧急告警",style: TextStyle(fontSize: 26),),
                Text("下行列车据您8.8KM"),
                Row(
                  children: [
                    Text("位置：8.8KM"),
                    Text("车次：A8975"),
                  ],
                ),
                Row(
                  children: [
                    Text("方向：下行"),
                    Text("轨道：L008"),
                  ],
                )
              ],
            )

          ],
        )
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.all(5),
        //           child: Image(
        //             image: AssetImage("assets/images/msg_item_icon.png"),
        //             width: 20.0,
        //             height: 20.0,
        //             color: Color(0X452d8cf0),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Expanded(
        //           flex: 1,
        //           child: Text(
        //             "普通公告",
        //             style: TextStyle(fontSize: 18, color: Colors.black),
        //           ),
        //         ),
        //         Text(
        //           data.createTime,
        //           style: TextStyle(fontSize: 12, color: Colors.black45),
        //         )
        //       ],
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 40),
        //       child: Text(
        //         "data.noticeTitle",
        //         style: TextStyle(fontSize: 12, color: Colors.black45),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 40),
        //       child: Text(
        //         " data.noticeContent",
        //         maxLines: 1,
        //         style: TextStyle(fontSize: 12, color: Colors.black45),
        //       ),
        //     ),
        //     // Html(data: """${data.noticeContent}"""),
        //   ],
        // ),
        );
  }
}

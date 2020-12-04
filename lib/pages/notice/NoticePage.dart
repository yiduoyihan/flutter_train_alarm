import 'dart:async';

import 'package:f_train_alarm/api/CommonService.dart';
import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/model/login/base_bean_entity.dart';
import 'package:f_train_alarm/model/login/home_list_bean_entity.dart';
import 'package:f_train_alarm/pages/notice/PageOneItemCard.dart';
import 'package:f_train_alarm/pages/web/WebViewExample.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:toast/toast.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  String _deviceId, _token;
  String _date;
  List<HomeListBeanData> dataList = List();

  @override
  void initState() {
    super.initState();
    SpUtil.getData<String>(GlobalConfig.deviceId).then((value) {
      _deviceId = value;
    });
    SpUtil.getData<String>(GlobalConfig.token).then((value) {
      _token = value;
    });

    Timer(Duration(milliseconds: 100), () {
      if (_date == null) {
        _date = DateTime.now().toString();
      }
      _refreshData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        page++;
        Timer(Duration(milliseconds: 100), () {
          _loadMoreData(page, DateTime.now().toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公告"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    // 是否展示顶部操作按钮
                    showTitleActions: true,
                    // 最小时间
                    minTime: DateTime(2018, 3, 5),
                    // 最大时间
                    maxTime: DateTime.now(),
                    // change事件
                    onChanged: (date) {
                  print('change $date');
                },
                    // 确定事件
                    onConfirm: (date) {
                  //拿到日期后调用接口来获取列表数据
                  print('confirm $date');
                  _date = date.toString();
                  _refreshData();
                },
                    // 当前时间
                    currentTime: DateTime.now(),
                    // 语言
                    locale: LocaleType.zh);
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return ListView.builder(
              controller: _scrollController,
              itemCount: dataList.length + 1,
              itemBuilder: (context, index) {
                //判断是否构建到了最后一条item
                if (index == dataList.length) {
                  //加载到的最后一页不满20条数据
                  if (dataList.length % 20 > 19) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    );
                  } else {
                    //已经加载了100条数据，不再获取数据。
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ));
                  }
                } else {
                  return GestureDetector(
                    child: PageOneItemCard(
                      data: dataList[index],
                    ),
                    onTap: () {
                      //itme 点击事件后面再处理
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WebViewExample(
                              // 路由参数
                              text: dataList[index].noticeContent,
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            );
          }),
        ),
      ),
    );
  }

  //
  Future<void> _refreshData() async {
    CommonService().getNoticeList(
        _token,
        _deviceId,
        0,
        20,
        "${_date.toString().substring(0, 10)} 00:00:00",
        "${_date.toString().substring(0, 10)} 23:59:59",
        (HomeListBeanEntity _bean) {
      if (_bean.code == 200) {
        Toast.show("请求成功", context);
        dataList.clear();
        setState(() {
          dataList.addAll(_bean.data);
          print("打印list长度：${dataList.length}");
        });
      } else {
        Toast.show("请求失败", context);
      }
    });
  }

  _loadMoreData(int page, String date) {
    CommonService().getNoticeList(
        _token,
        _deviceId,
        page,
        20,
        "${date.toString().substring(0, 10)} 00:00:00",
        "${date.toString().substring(0, 10)} 23:59:59",
        (HomeListBeanEntity _bean) {
      if (_bean.code == 200) {
        Toast.show("请求成功", context);
        setState(() {
          dataList.addAll(_bean.data);
        });
      } else {
        Toast.show("请求失败", context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:async';

import 'package:f_train_alarm/api/CommonService.dart';
import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/SpUtil.dart';
import 'package:f_train_alarm/pages/alarm/HistoryAlarmItemCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_train_alarm/model/login/history_list_data_entity.dart';
import 'package:toast/toast.dart';

class HistoryAlarmPage extends StatefulWidget {
  @override
  _HistoryPage createState() => new _HistoryPage();
}

class _HistoryPage extends State<HistoryAlarmPage> {
  int page = 0;
  int pageCount = 20;

  int regId = 1;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  List<HistoryListDataData> dataList = List();
  String _deviceId, _token;

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
        title: Text("历史告警"),
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
                    child: HistoryAlarmItemCard(
                      data: dataList[index],
                    ),
                  );
                }
              },
            );
          }),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    page = 0;
    CommonService().getHistoryAlarmList(_token, _deviceId,page, pageCount, regId,
        (HistoryListDataEntity _bean) {
      if (_bean.code == 200) {
        Toast.show("请求成功", context);
        dataList.clear();
        setState(() {
          dataList.addAll(_bean.data);
          print("打印list长度：${dataList.length}");
        });
      } else {
        Toast.show("请求失败:${_bean.msg}", context);
      }
    });
  }

  _loadMoreData(int page, String date) {
    CommonService().getHistoryAlarmList(_token, _deviceId, page, pageCount, regId,
            (HistoryListDataEntity _bean) {
          if (_bean.code == 200) {
            Toast.show("请求成功", context);
            setState(() {
              dataList.addAll(_bean.data);
              print("打印list长度：${dataList.length}");
            });
          } else {
            Toast.show("请求失败:${_bean.msg}", context);
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

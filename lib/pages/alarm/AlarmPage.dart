import 'package:f_train_alarm/map/map_base_page_state.dart';
import 'package:f_train_alarm/pages/alarm/HistoryAlarmPage.dart';
import 'package:f_train_alarm/pages/alarm/SearchTrackPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_view.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_map_options.dart';
///要导这个不然找不到BMFCoordinate类
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';


class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends BMFBaseMapState<AlarmPage> {

  // BMFCoordinate center = BMFCoordinate(39.965, 116.404);

  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 12,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

  @override
  Widget build(BuildContext context) {
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
        height: screenSize.height,
        width: screenSize.width,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: mapOptions,
        ),
      ),
    );
  }
}


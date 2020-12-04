import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryAlarmPage extends StatefulWidget {
  @override
  _HistoryPage createState() => new _HistoryPage();
}

class _HistoryPage extends State<HistoryAlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史告警"),
      ),
    );
  }
}

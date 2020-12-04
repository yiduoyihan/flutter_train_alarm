import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTrackPage extends StatefulWidget {
  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchTrackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("轨迹查询"),
      ),
    );
  }
}

import 'package:f_train_alarm/common/GlobalConfig.dart';
import 'package:f_train_alarm/common/MyIcons.dart';
import 'package:f_train_alarm/pages/alarm/AlarmPage.dart';
import 'package:f_train_alarm/pages/notice/NoticePage.dart';
import 'package:f_train_alarm/pages/self/SelfPage.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationPageState();
  }
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController _pageController;

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(MyIcons.home),
        label: GlobalConfig.homeTab,
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(MyIcons.alarm),
        label: GlobalConfig.alarmTab,
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(MyIcons.self),
        label: GlobalConfig.selfTab,
        backgroundColor: GlobalConfig.colorPrimary),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._page);
    // _pageController = PageController(length : 4,async:);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          NoticePage(),
          AlarmPage(),
          SelfPage(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}

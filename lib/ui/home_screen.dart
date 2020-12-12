import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techmaster_lesson_2/model/drawer_item.dart';
import 'package:techmaster_lesson_2/model/issue.dart';
import 'package:techmaster_lesson_2/model/response.dart';
import 'package:techmaster_lesson_2/navigator.dart';
import 'package:techmaster_lesson_2/ui/change_password_screen.dart';
import 'package:techmaster_lesson_2/ui/contact_screen.dart';
import 'package:techmaster_lesson_2/ui/report_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final icons = [
    Icons.menu,
    Icons.report,
    Icons.security_outlined,
    Icons.rule,
    Icons.contact_phone_outlined,
    Icons.logout
  ];
  final titles = [
    'Sự cố',
    'Báo cáo',
    'Đổi mật khẩu',
    'Điều khoản',
    'Liên hệ',
    'Đăng xuất'
  ];

  final drawerWidgets = [
    HomeScreen(),
    ReportScreen(),
    ChangePasswordScreen(),
    Container(),
    ContactScreen(),
    Container(),
  ];

  List<DrawerItem> drawerItems = List();
  List<Issue> issues = List();

  @override
  void initState() {
    for (int i = 0; i < icons.length; i++) {
      drawerItems.add(DrawerItem(icons[i], titles[i]));
    }
    getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: SafeArea(child: buildDrawer()),
      body: buildBody(),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      semanticLabel: '123231',
      child: Container(
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildInfo(),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 16,
                  ),
                  itemCount: drawerItems == null ? 0 : drawerItems.length,
                  itemBuilder: (BuildContext context, i) {
                    return buildDrawerItem(drawerItems[i], i);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/logo.png',
              width: 30,
              height: 30,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khanh Le',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '0963003197',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(DrawerItem item, int index) {
    return GestureDetector(
      onTap: () {
        onDrawerItemClick(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(item.icon),
                SizedBox(
                  width: 5,
                ),
                Text(item.title),
              ],
            ),
            index == 0 ||
                    index == drawerItems.length - 2 ||
                    index == drawerItems.length - 3
                ? horizontalLine()
                : Container(),
          ],
        ),
      ),
    );
  }

  void onDrawerItemClick(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        Navigator.of(context).pop();
        navigatorPush(context, drawerWidgets[index]);
        break;
      case 5:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        break;
    }
  }

  Widget horizontalLine() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
  }

  Widget verticalLine() {
    return Container(
      width: 1,
      height: double.infinity,
      color: Colors.grey,
    );
  }

  Widget buildBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListView.builder(
        itemBuilder: (ctx, index) => buildItem(),
        itemCount: issues.length,
      ),
    );
  }

  Widget buildItem() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [],
          ),
        ],
      ),
    );
  }

  Future<void> getIssues() async {
    var r = Request(5, 0);
    String url = 'http://report.bekhoe.vn/api/issues';
    var response = await http.post(url, body: r.toJson().toString());
    print('_HomeScreenState.getIssues ${response.toString()}');
    APIResponse apiResponse = jsonDecode(response.body);
    print('_HomeScreenState.getIssues $apiResponse');
  }
}

class Request {
  int limit;
  int offset;

  Request(this.limit, this.offset);

  Map<String, dynamic> toJson() => {
        'limit': limit,
        'offset': offset,
      };
}

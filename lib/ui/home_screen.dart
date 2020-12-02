import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/model/drawer_item.dart';

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

  List<DrawerItem> drawerItems = List();

  @override
  void initState() {
    for (int i = 0; i < icons.length; i++) {
      drawerItems.add(DrawerItem(icons[i], titles[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: buildDrawer(),
      body: Container(
        child: buildBody(),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
        child: Container(
      height: double.maxFinite,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildInfo(),
            Expanded(
              child: ListView.builder(
                  itemCount: drawerItems == null ? 0 : drawerItems.length,
                  itemBuilder: (BuildContext context, i) {
                    return buildDrawerItem(drawerItems[i]);
                  }),
            )
          ]),
    ));
  }

  Widget buildInfo() {
    return Container(
      color: Colors.green,
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset('assets/logo.png'),
            radius: 20,
          ),
          Container(
            height: double.infinity,
            color: Colors.yellow,
            alignment: AlignmentDirectional.center,
            child: Column(
              children: [
                Text('Khanh Le'),
                Text('0963003197'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(DrawerItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(item.icon),
          SizedBox(
            width: 5,
          ),
          Text(item.title),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Container();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:techmaster_lesson_2/blocs/issue_bloc.dart';
import 'package:techmaster_lesson_2/model/drawer_item.dart';
import 'package:techmaster_lesson_2/model/issue_response.dart';
import 'package:techmaster_lesson_2/model/login_response.dart';
import 'package:techmaster_lesson_2/navigator.dart';
import 'package:techmaster_lesson_2/shared_prefs_helper.dart';
import 'package:techmaster_lesson_2/ui/account_screen.dart';
import 'package:techmaster_lesson_2/ui/change_password_screen.dart';
import 'package:techmaster_lesson_2/ui/contact_screen.dart';
import 'package:techmaster_lesson_2/ui/photo_view.dart';
import 'package:techmaster_lesson_2/ui/report_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final Data userResponse;

  const HomeScreen({Key key, this.userResponse}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const API_URL = 'http://report.bekhoe.vn';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  IssueBloc bloc = IssueBloc();
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
    Scaffold(
      appBar: AppBar(
        title: Text('Dieu khoan'),
      ),
      body: Container(
        child: Center(child: Text('Dieu khoan')),
      ),
    ),
    ContactScreen(),
    Container(),
  ];

  List<DrawerItem> drawerItems = List();
  SharedPrefsHelper sharedPrefsHelper;

  @override
  void initState() {
    for (int i = 0; i < icons.length; i++) {
      drawerItems.add(DrawerItem(icons[i], titles[i]));
    }
    sharedPrefsHelper = SharedPrefsHelper();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text(
          'Sự cố',
        ),
        centerTitle: true,
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        navigatorPush(
          context,
          AccountScreen(
            userResponse: widget.userResponse,
          ),
        );
      },
      child: Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '$API_URL${widget.userResponse.avatar}',
                width: 50,
                height: 50,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.userResponse.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${widget.userResponse.phoneNumber}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(DrawerItem item, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
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
        setState(() {});
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
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('_HomeScreenState.buildBody *hien thi');
          final issues = snapshot.data;

          return Container(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) => buildItem(issues[index]),
              itemCount: issues.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 5,
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildItem(Datum issue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '$API_URL${issue.accountPublic.avatar}',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            issue.accountPublic.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${issue.createdAt}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text('adfadsfadsf'),
            ],
          ),
          horizontalLine(),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                issue.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                issue.content,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          buildListImage(issue.photos),
        ],
      ),
    );
  }

  Widget buildListImage(List<dynamic> photos) {
    print('_HomeScreenState.buildListImage ${photos.toString()}');
    return photos.isNotEmpty
        ? Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(photos.length),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) =>
                  buildImageItem(photos[index].toString()),
            ),
          )
        : Container();
  }

  Widget buildImageItem(String url) {
    return GestureDetector(
      onTap: () {
        navigatorPush(context, PhotoViewScreen(imageUrl: '$API_URL$url'));
      },
      child: Container(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: "$API_URL$url",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  int getCrossAxisCount(int itemCount) {
    if (itemCount == 1) {
      return 1;
    }
    if (itemCount == 2) {
      return 2;
    }
    if (itemCount >= 3) {
      return 3;
    }
    return 0;
  }
}

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PhotoView(imageProvider: NetworkImage(imageUrl)),
    );
  }
}

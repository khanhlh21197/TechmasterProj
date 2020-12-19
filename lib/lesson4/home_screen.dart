import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techmaster_lesson_2/lesson4/login_screen.dart';
import 'package:techmaster_lesson_2/model/contact.dart';
import 'package:techmaster_lesson_2/navigator.dart';
import 'package:techmaster_lesson_2/utilities/shared_preferences_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var contacts = List<Contact>();

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              sharedPreferences.remove(tokenKey);
              navigatorPushAndRemoveUntil(context, LoginScreen());
            },
          )
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: buildContacts(),
    );
  }

  Widget buildContacts() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return buildItem(contacts[index]);
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 15);
  }

  Widget buildItem(Contact contact) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 64,
            child: ClipOval(
              child: Image.network(
                contact.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(child: Text('name')),
        ],
      ),
    );
  }

  Future<void> getContacts() async {
    String url = 'http://report.bekhoe.vn/api/users/all';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      contacts = contactFromJson(response.body);
      print('_HomeScreenState.getContacts ${response.body}');
      print('_HomeScreenState.getContacts ${contacts.length}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

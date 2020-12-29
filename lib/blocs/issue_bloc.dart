import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:techmaster_lesson_2/model/issue_response.dart';
import 'package:techmaster_lesson_2/utilities/api_service.dart';

import '../shared_prefs_helper.dart';

class IssueBloc {
  StreamController _streamController = StreamController<List<Datum>>.broadcast();

  Stream<List<Datum>> get stream => _streamController.stream;
  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

  IssueBloc() {
    getIssues();
  }

  void dispose() {
    _streamController.close();
  }

  Future getIssues() async {
    String token = await sharedPrefsHelper.getStringValuesSF('token');
    print('_HomeScreenState.getIssues $token');
    var r = Request('5', '0');
    var queryParameters = r.toJson();

    // apiService.request(
    //   path: apiService.getIssue,
    //   method: Method.get,
    //   onFailure: (message){},
    //   onSuccess: (response){
    //     _streamController.add(List<Datum>.from(response.map((x) => Datum.fromJson(x))));
    //   },
    // );

    var uri = Uri.http('report.bekhoe.vn', '/api/issues', queryParameters);
    print('_HomeScreenState.getIssues $uri');
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('_HomeScreenState.getIssues ${response.statusCode}');
    final issueResponse = issueResponseFromJson(response.body);
    _streamController.add(issueResponse.data);
  }
}

class Request {
  String limit;
  String offset;

  Request(this.limit, this.offset);

  Map<String, String> toJson() => {
        'limit': limit,
        'offset': offset,
      };
}

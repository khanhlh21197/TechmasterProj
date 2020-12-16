import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return WebView(
      initialUrl: widget.url,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('tel:')) {
          print('Mo goi dien');
          return NavigationDecision.prevent;
        }
        print('${request.url}');
        return NavigationDecision.navigate;
      },
      onPageStarted: (url) {
        print('Page started loading: $url');
      },
      onPageFinished: (url) {
        print('Page finished loading: $url');
      },
    );
  }
}

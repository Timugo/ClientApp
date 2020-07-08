//Flutter and Dart dependencies
import 'dart:async';
import 'package:flutter/material.dart';
// Plugins
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPoliticies extends StatelessWidget {
  final Completer<WebViewController> _controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://api.timugo.com/politics/privacy.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      )
    );
  }
}

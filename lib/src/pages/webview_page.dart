import 'dart:async';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        body: WebView(
          initialUrl:'https://timugo.tk/politics/privacy.html' ,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
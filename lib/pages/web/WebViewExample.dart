import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  WebViewExample({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  WebViewExampleState createState() => WebViewExampleState(text);
}

class WebViewExampleState extends State<WebViewExample> {
  String url;
  String linkCss;
  WebViewExampleState(String text) {
    // url = text;
    String str1 = "<!DOCTYPE HTML><html><HEAD>";
    linkCss =
        "<link rel=\"stylesheet\" href=\"file:///android_asset/flutter_assets/assets/web.css\">";
    String str3 = "</HEAD><body>";
    String str4 = "<div class=\"ql-editor\">";
    // sb.append(text);
    String str5 = "</div></body></html>";
    url = str1 + linkCss + str3 + str4 + text + str5;
    print("url=$url");
    // webView.loadDataWithBaseURL(
    //     linkCss, sb.toString(), "text/html", "UTF-8", null);
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,

        ///JS执行模式
        // initialUrl: '$url',
        onWebViewCreated: (WebViewController controller) {
          controller.loadUrl(Uri.dataFromString(url,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
              .toString());
        },
      ),
    );
  }
}

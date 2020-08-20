import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomizeWebView extends StatefulWidget {
  @override
  _CustomizeWebViewState createState() => _CustomizeWebViewState();
}

class _CustomizeWebViewState extends State<CustomizeWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize WebView '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: AndroidView(
            viewType: 'webview',
            creationParams: {
              "url": "https://flutterchina.club/",
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      ),
    );
  }
}

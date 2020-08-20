import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidTextViewWidget extends StatefulWidget {
  @override
  _AndroidTextViewWidgetState createState() => _AndroidTextViewWidgetState();
}

class _AndroidTextViewWidgetState extends State<AndroidTextViewWidget> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Android view'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: AndroidView(
            viewType: 'plugins.nightfarmer.top/myview',
            creationParams: {
              "myContent": "通过参数传入的文本内容",
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      ),
    );
  }
}

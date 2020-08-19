import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview/webview/webview_community.dart';
import 'package:webview/webview/webview_official.dart';
import 'package:webview/widget/navigation_rail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 官方WebView
            CupertinoButton(
              child: Text('官方WebView'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewExample(),
                  ),
                );
              },
            ),

            // 社区 webview
            CupertinoButton(
              child: Text('社区WebView'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewOfficial(),
                  ),
                );
              },
            ),

            // NavigationRail
            CupertinoButton(
              child: Text('NavigationRailWidget'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvancedScene(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

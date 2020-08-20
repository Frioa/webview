import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HybridComposition extends StatefulWidget {
  @override
  _HybridCompositionState createState() => _HybridCompositionState();
}

class _HybridCompositionState extends State<HybridComposition> {
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    final String viewType = 'webview';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'url': 'https://flutterchina.club/'
    };

    return Scaffold(
      appBar: AppBar(title: Text('Hybrid Composition')),
      body: PlatformViewLink(
        viewType: viewType,
        //  surfaceFactory 返回一个 AndroidViewSurface 用于处理绘制和接受触摸事件；
        surfaceFactory:
            (BuildContext context, PlatformViewController controller) {
          return AndroidViewSurface(
            controller: controller,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        // PlatformViewsService 初始化 AndroidViewSurface 和初始化所需要的参数，同时通过 Engine 去触发原生层的显示。
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      ),
    );
  }
}


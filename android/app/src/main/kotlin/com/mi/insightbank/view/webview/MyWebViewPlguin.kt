package com.mi.insightbank.view.webview

import io.flutter.embedding.engine.plugins.FlutterPlugin

class MyWebViewPlguin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val messenger = binding.binaryMessenger
        binding
                .flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory(
                        "webview", MyWebViewFactory(messenger))
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        TODO("Not yet implemented")
    }

}
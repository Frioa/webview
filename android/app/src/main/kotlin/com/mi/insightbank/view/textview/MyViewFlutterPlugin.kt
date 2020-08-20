package com.mi.insightbank.view.textview

import android.util.Log
import com.mi.insightbank.view.textview.MyViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

class MyViewFlutterPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("MyViewFlutterPlugin", "onAttachedToEngine")
        val messenger = binding.binaryMessenger

        binding
                .flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory(
                        "plugins.nightfarmer.top/myview", MyViewFactory(messenger))
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        TODO("Not yet implemented")
    }

}
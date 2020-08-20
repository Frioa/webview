package com.mi.insightbank.webview

import android.os.Bundle
import androidx.annotation.NonNull
import com.mi.insightbank.view.textview.MyViewFlutterPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.plugins.add(MyViewFlutterPlugin())
    }
}

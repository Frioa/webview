package com.mi.insightbank.webview

import android.content.Context
import android.util.Log
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView


class MyTextView constructor(val context: Context, messenger: BinaryMessenger, id :Int, params: Map<String, Any>): PlatformView {

    var textView :TextView = TextView(context)

    override fun getView(): View {
//        textView.findViewById<TextView>(R.id.textView);
        textView.text = "Android 原生 TextView"
        return textView
    }

    override fun dispose() {
        Log.d("MyTextView", "despost()")
    }
}

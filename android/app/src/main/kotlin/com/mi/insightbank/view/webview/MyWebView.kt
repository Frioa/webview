package com.mi.insightbank.view.webview

import android.content.Context
import android.util.Log
import android.view.View
import android.webkit.WebView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView


class MyWebView constructor(val context: Context, messenger: BinaryMessenger, id :Int, val params: Map<String, Any>): PlatformView {

    var webView : WebView = WebView(context)

    override fun getView(): View {
        if (params.containsKey("url")) {
            val url = params["url"] as String?
            webView.loadUrl(url)
        } else {
            webView.loadUrl("https://flutterchina.club/")
        }
        return webView
    }

    override fun dispose() {
        Log.d("MyTextView", "despost()")
    }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab_v4/Provider/webview_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    final providerdata = Provider.of<Webcontroll>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                providerdata.webViewController!.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () {
                providerdata.webViewController!.goForward();
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ],
        title: Text(widget.url),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 2.0,
            backgroundColor: Colors.white70.withOpacity(0),
            value: providerdata.lineprogress == 1.0
                ? 0.0
                : providerdata.lineprogress,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                providerdata.registerWebview(webViewController);
              },
              allowsInlineMediaPlayback: true,
              gestureNavigationEnabled: true,
              debuggingEnabled: true,
              onProgress: (int progress) {
                providerdata.linearpogress(progress.toDouble() / 100);
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          ),
        ],
      ),
    );
  }
}

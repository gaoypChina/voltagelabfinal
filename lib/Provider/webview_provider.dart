import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webcontroll extends ChangeNotifier {
  WebViewController? webViewController;

  double linerProgress = 0.0;


  double get lineprogress => linerProgress;



  void loadurlweb(String url) {
    webViewController!.loadUrl(url);
    notifyListeners();
  }

  void registerWebview(WebViewController wvc) {
    webViewController = wvc;
    notifyListeners();
  }

  void linearpogress(double progress) {
    linerProgress = progress;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeBeritaDetailPage extends StatefulWidget {
  final String url;
  final String title;
  const HomeBeritaDetailPage(
      {super.key, required this.url, required this.title});

  @override
  State<HomeBeritaDetailPage> createState() => _HomeBeritaDetailPageState();
}

class _HomeBeritaDetailPageState extends State<HomeBeritaDetailPage> {
  final webController = WebViewController();
  var loadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webController
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryBlueBlack,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: webController,
          ),
          if(loadingPercentage < 100)
            LinearProgressIndicator(
              color: primaryRed,
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}

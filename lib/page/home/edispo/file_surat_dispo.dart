import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FileSuratDispo extends StatefulWidget {
  final String fileSurat;

  const FileSuratDispo({super.key, required this.fileSurat});

  @override
  State<FileSuratDispo> createState() => _FileSuratDispoState();
}

class _FileSuratDispoState extends State<FileSuratDispo> {
  late final WebViewController pdfcontroller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    pdfcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xffffffff))
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }))
      ..loadRequest(Uri.parse('https://google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryBlueBlack,
          title: Text(
            'Preview File',
            style: title.copyWith(color: white),
          ),
        ),
        body: widget.fileSurat != null
            ? tampilinFile(widget.fileSurat)
            : Container());
  }

  Widget tampilinFile(String fileSurat) {
    final urlFileSurat =
        "http://119.2.50.170:9095/e_dispo/assets/temp/file_surat/$fileSurat";

    if (fileSurat.substring(fileSurat.length - 3) == "png" ||
        (fileSurat.substring(fileSurat.length - 3) == "jpg")) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CachedNetworkImage(
          imageUrl: urlFileSurat,
        ),
      );
    } else if (fileSurat.substring(fileSurat.length - 3) == "pdf") {
      return Stack(children: [
        PDF().cachedFromUrl(
          'http://119.2.50.170:9095/e_dispo/assets/temp/file_surat/${widget.fileSurat}',
          placeholder: (double progress) => Center(child: const CircularProgressIndicator()),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          )
      ]);
    } else {
      return Container();
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:my_darling_app/theme/theme.dart';

class FileSuratDispo extends StatefulWidget {
  final String fileSurat;

  const FileSuratDispo({super.key, required this.fileSurat});

  @override
  State<FileSuratDispo> createState() => _FileSuratDispoState();
}

class _FileSuratDispoState extends State<FileSuratDispo> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
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
      return Container(
        child: const PDF().cachedFromUrl(
          'http://119.2.50.170:9095/e_dispo/assets/temp/file_surat/${widget.fileSurat}',
          placeholder: (double progress) => const Center(child: CircularProgressIndicator()),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
      );
    }
    else {
      return Container();
    }
  }
}

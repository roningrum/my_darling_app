import 'package:flutter/material.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';


class FileSuratDispo extends StatefulWidget {
  final String fileSurat;
  const FileSuratDispo({super.key, required this.fileSurat});

  @override
  State<FileSuratDispo> createState() => _FileSuratDispoState();
}

class _FileSuratDispoState extends State<FileSuratDispo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Preview File',
          style: title.copyWith(color: white),
        ),
      ),
      body: widget.fileSurat!=null?

      ,
    );
  }
}

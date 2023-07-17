import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';

class HomeArtikelBeritaItem extends StatefulWidget {
  final String judulBerita;
  final String imageBerita;

  const HomeArtikelBeritaItem({super.key, required this.judulBerita, required this.imageBerita});

  @override
  State<HomeArtikelBeritaItem> createState() => _HomeArtikelBeritaItemState();
}

class _HomeArtikelBeritaItemState extends State<HomeArtikelBeritaItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(widget.imageBerita),
            ),
            const SizedBox(height: 8),
            Text(
              widget.judulBerita,
              style: title.copyWith(color: primaryBlueBlack, fontSize: 14),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

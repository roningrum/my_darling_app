import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';

class HomeArtikelBeritaItem extends StatelessWidget {
  String judulBerita;
  String isiBerita;
  String imageBerita;

  HomeArtikelBeritaItem(this.judulBerita, this.isiBerita, this.imageBerita,
      {Key? key})
      : super(key: key);

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
              child: Image.asset(imageBerita),
            ),
            const SizedBox(height: 8),
            Text(
              judulBerita,
              style: title.copyWith(color: primaryBlueBlack, fontSize: 14),
            ),
            const SizedBox(height: 8),
            RichText(
                maxLines: 3,
                text: TextSpan(
                    style: TextStyle(color: secondaryBlueBlack.withOpacity(0.8), fontSize: 12),
                    text: isiBerita)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

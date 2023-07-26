import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';

class HomeBannerChart extends StatefulWidget {
  const HomeBannerChart({super.key});

  @override
  State<HomeBannerChart> createState() => _HomeBannerChartState();
}

class _HomeBannerChartState extends State<HomeBannerChart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Aktivitas Harian',
          style: title.copyWith(color: white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child:  Column(
          children: [
            Text("Riwayat Langkah", style: title.copyWith(fontSize: 16, color: primaryBlueBlack),)
          ],
        ),
      ),
    );
  }
}

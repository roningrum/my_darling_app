import 'package:flutter/material.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/widget/edispo/kegiatan_luar_item.dart';

import '../../../helper/date_helper.dart';
import '../../../repository/model/kegiatan_luar_response.dart';
import '../../../theme/theme.dart';

class KegiatanExternalBidang extends StatefulWidget {
  const KegiatanExternalBidang({Key? key}) : super(key: key);

  @override
  State<KegiatanExternalBidang> createState() => _KegiatanExternalBidangState();
}

class _KegiatanExternalBidangState extends State<KegiatanExternalBidang> {
  final TextEditingController datePickerController = TextEditingController();
  final NetworkRepo _networkRepo = NetworkRepo();
  String? selectedBidang;
  String? dateTime;

  @override
  void initState() {
    super.initState();
    datePickerController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan External',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              daftarKegiatanLuar()
            ],
          ),
        ),
      ),
    );
  }

  Widget daftarKegiatanLuar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        Text('Kegiatan Luar Bidang pada ${getTodayDate()}',
          style: title.copyWith(
              fontSize: 14.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
        const SizedBox(height: 16.0),
        FutureBuilder<List<KegiatanLuar>>(
            future: _networkRepo.getKegiatanExternal("4",dateParameter()),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!=null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return KegiatanLuarItem(kegiatanLuar: snapshot.data![index]);
                      }));
                } else {
                  return Center(
                    child: Text("Tidak ada kegiatan hari ini",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                }
              } else if(snapshot.hasError) {
                return Center(
                  child: Text("Tidak ada kegiatan hari ini",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                );
              }
              else{
                return Center(child: CircularProgressIndicator(color: primaryRed));
              }
            }),
      ],
    );
  }

}

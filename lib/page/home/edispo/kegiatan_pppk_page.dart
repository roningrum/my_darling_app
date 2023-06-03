import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/Kegiatan_pppk_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/widget/edispo/kegiatan_pppk_item.dart';

import '../../../theme/theme.dart';

class KegiatanPPPKPage extends StatefulWidget {
  const KegiatanPPPKPage({Key? key}) : super(key: key);

  @override
  State<KegiatanPPPKPage> createState() => _KegiatanPPPKPageState();
}

class _KegiatanPPPKPageState extends State<KegiatanPPPKPage> {
  // TextEditingController datePickerController = TextEditingController();
  final _networkRepo = NetworkRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // datePickerController.text = "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan PPPK',
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
              // searchByTanggal(),
              daftarPPPK()
            ],
          ),
        ),
      ),
    );
  }

  Widget daftarPPPK() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        Text('Kegiatan PPPK pada ${getTodayDate()}',
          style: title.copyWith(
              fontSize: 14.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
        const SizedBox(height: 16.0),
        FutureBuilder<List<KegiatanPppk>>(
            future: _networkRepo.getKegiatanPPPK("2020-03-14", dateParameter()),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!=null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return KegiatanPPPKItem(kegiatanPppk: snapshot.data![index]);
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

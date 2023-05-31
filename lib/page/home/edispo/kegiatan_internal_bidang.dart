import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/kegiatan_internal_response.dart';
import 'package:my_darling_app/widget/edispo/kegiatan_internal_item.dart';
import '../../../repository/network_repo.dart';
import '../../../theme/theme.dart';

class KegiatanInternalBidang extends StatefulWidget {
  const KegiatanInternalBidang({Key? key}) : super(key: key);

  @override
  State<KegiatanInternalBidang> createState() => _KegiatanInternalBidangState();
}

class _KegiatanInternalBidangState extends State<KegiatanInternalBidang> {
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Kegiatan Internal Bidang',
              style: title.copyWith(color: Colors.white, fontSize: 16)),
          backgroundColor: primaryBlueBlack,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: daftarKegiatanInternal())
            ],
          ),
        ));
  }

  Widget searchByTanggal() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            TextField(
                controller: datePickerController,
                readOnly: true,
                decoration: InputDecoration(
                    fillColor: white,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: secondaryBlueBlack)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: primaryRed)),
                    prefixIcon: Icon(Icons.search, color: secondaryBlueBlack),
                    label: Text(
                      'Cari tanggal',
                      style: regular.copyWith(color: secondaryBlueBlack),
                    )),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      datePickerController.text = formattedDate;
                    });
                  } else {
                    if (kDebugMode) {
                      print("Date is not selected");
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget daftarKegiatanInternal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text('Kegiatan Internal Bidang pada ${getTodayDate()}',
            style: title.copyWith(
                fontSize: 14.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
        const SizedBox(height: 16.0),
        FutureBuilder<List<KegiatanInternal>>(
            future: _networkRepo.getKegiatanInternal("4", dateParameter()),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return KegiatanInternalItem(
                            kegiatanInternal: snapshot.data![index]);
                      }));
                } else {
                  return Center(
                    child: Text("Tidak ada kegiatan hari ini",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator(color: primaryRed));
              }
            }),
      ],
    );
  }
}

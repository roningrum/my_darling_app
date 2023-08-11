import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/page/home/edispo/surat_detail_page.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/surat_item.dart';

class SuratBelumDiproses extends StatefulWidget {
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;
  const SuratBelumDiproses({super.key, required this.jenisSurat, required this.rule, required this.bidang, required this.userId, required this.seksi});

  @override
  State<SuratBelumDiproses> createState() => _SuratBelumDiprosesState();
}

class _SuratBelumDiprosesState extends State<SuratBelumDiproses> {
  TextEditingController dateinput = TextEditingController();

  final _networkRepo = NetworkRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: dateinput,
              onTap: () {
                _selectDate();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onChanged: (value){
                dateinput.text = value;
              },
              style: regular.copyWith(fontSize: 14.0),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfff1f1f1),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Cari Tanggal Surat",
                  hintStyle: regular.copyWith(
                      letterSpacing: 0.5,
                      color: const Color(0xffdadada)
                  ),
                  prefixIcon: const Icon(Icons.date_range),
                  prefixIconColor: const Color(0xff888888)
              ),
            ),
            const SizedBox(height: 12.0),
            dateinput.text== ""? daftarSuratBelum(
                widget.rule, widget.bidang, widget.seksi, widget.userId): dataSuratbyTgl(dateinput.text)
          ],
        ),
      ),
    );
  }

  Widget daftarSuratBelum(String rule, String bidang, String seksi,
      String userId) {
    if (kDebugMode) {
      print('Data rule $rule, bidang $bidang, seksi $seksi, userId $userId');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        FutureBuilder<List<Surat>>(
            future: _networkRepo.getSuratBelumProses(
                widget.jenisSurat, rule, bidang, seksi, userId),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (kDebugMode) {
                print('List : $data');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (data == null) {
                  return dataNoFoundWidget();
                }
                else {
                  var dataLength = data.length;
                  if (dataLength == 0) {
                    return dataNoFoundWidget();
                  }
                  else {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return SuratItem(surat: data[index], rule: widget.rule);
                      }),
                    );
                  }
                }
              }
              else {
                return Center(child: CircularProgressIndicator(color: primaryRed,));
              }
            })
      ],
    );
  }

  Widget dataNoFoundWidget() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/no_data.svg', height: 100, width: 100),
          const SizedBox(height: 24),
          Text('Tidak ada Surat ${widget.jenisSurat} ditemukan',
            style: regular.copyWith(
                color: secondaryBlueBlack, fontWeight: FontWeight.w400),)
        ],
      ),
    );
  }

  Future _selectDate() async {
    var picked = await showDatePicker(context: context,
        initialDate:DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if(picked != null){
      setState(() {
        dateinput.text = formatTanggal(picked.toString());
        if(kDebugMode){
          print("Tanggal ${dateinput.text}");
        }
      });
    }
  }

  Widget dataSuratbyTgl(String tglAgenda) {
    return FutureBuilder<List<Surat>>(
        future: _networkRepo.getSuratBelumProsesByTgl(
            widget.jenisSurat, widget.rule, widget.bidang, widget.seksi, widget.userId, tglAgenda),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (kDebugMode) {
            print('List : $data');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (data == null) {
              return dataNoFoundWidget();
            }
            else {
              var dataLength = data.length;
              if (dataLength == 0) {
                return dataNoFoundWidget();
              }
              else {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return SuratItem(surat: data[index], rule: widget.rule,);
                  }),
                );
              }
            }
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }


}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/page/home/agenda_surat_detail.dart';
import 'package:my_darling_app/repository/model/agenda_surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/agenda_today_item.dart';

class AgendaSearchPage extends StatefulWidget {
  const AgendaSearchPage({super.key});

  @override
  State<AgendaSearchPage> createState() => _AgendaSearchPageState();
}

class _AgendaSearchPageState extends State<AgendaSearchPage> {
  TextEditingController dateinput = TextEditingController();

  final _networkRepo = NetworkRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Agenda',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              TextFormField(
                controller: dateinput,
                onTap: () {
                  _selectDate();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) {
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
              dateinput.text == '' ? Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                height: 800,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/agenda_search.svg', width: 100, height: 100,),
                    const SizedBox(height: 12.0),
                    Text("Silakan lakukan pencarian agenda",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack), textAlign: TextAlign.center,),
                  ],
                ),
              ) : dataAgenda(dateinput.text)
            ],
          ),
        ),
      ),
    );
  }

  Widget dataAgenda(String date) {
    return FutureBuilder<List<Data>>(
      future: _networkRepo.getAgenda(date, date),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return GestureDetector(
                    onTap: () =>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                AgendaSuratDetail(data: data))),
                    child: AgendaTodayItem(data: data));
              },
            );
          }
          else {
            return Center(
              child: Text("Tidak ada Agenda di tanggal tersebut",
                  style: regular.copyWith(
                      fontSize: 14.0, color: secondaryBlueBlack)),
            );
          }
        }
        else if (snapshot.hasError &&
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: Text("Cek Koneksi Kembali",
                style: regular.copyWith(
                    fontSize: 14.0, color: secondaryBlueBlack)),
          );
        }
        else {
          return Center(
            child: Text("Tidak ada Agenda hari ini",
                style: regular.copyWith(
                    fontSize: 14.0, color: secondaryBlueBlack)),
          );
        }
      },
    );
  }

  Future _selectDate() async {
    var picked = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        dateinput.text = formatTanggal(picked.toString());
        if (kDebugMode) {
          print("Tanggal ${dateinput.text}");
        }
      });
    }
  }
}

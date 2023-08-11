import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/file_surat_dispo.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratDetailPage extends StatefulWidget {
  final Surat surat;
  final String rulePegawai;

  const SuratDetailPage(
      {super.key, required this.surat, required this.rulePegawai});

  @override
  State<SuratDetailPage> createState() => _SuratDetailPageState();
}

class _SuratDetailPageState extends State<SuratDetailPage> {
  bool isLoading = false;
  final networkRepo = NetworkRepo();
  final sessionManager = SessionManager();

  List<String> dispoSelected = [];

  String? userId = "0";
  String? bidang = '';
  String? seksi = '';
  String? isi_dp = '';

  bool selected = false;

  Future<String?> getIdUser() async {
    userId = await sessionManager.getUserId("userId");
    return userId;
  }

  Future<String?> getIdBidang() async {
    bidang = await sessionManager.getBidang("bidang");
    return bidang;
  }

  Future<String?> getIdSeksi() async {
    seksi = await sessionManager.getBidang("seksi");
    return seksi;
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
    getIdBidang();
    getIdSeksi();
  }

  void _onLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: primaryRed),
                  const SizedBox(height: 20),
                  Text("Mohon Tunggu Sebentar", style: regular)
                ],
              ),
            ),
          );
        });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      sendData(widget.surat.idSurat, userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Detail Surat',
          style: title.copyWith(color: white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.surat.acara ?? '',
                style:
                    title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Tgl Surat',
                      style: regular.copyWith(
                          color: secondaryBlueBlack, fontSize: 14.0),
                      textAlign: TextAlign.start),
                ),
                Text(dateFormat(widget.surat.tglSurat!),
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Tgl Terima',
                      style: regular.copyWith(
                          color: secondaryBlueBlack, fontSize: 14.0),
                      textAlign: TextAlign.start),
                ),
                Text(dateFormat(widget.surat.tglTerima!),
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('No. Surat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.noSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('No. Agenda',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.noAgenda}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Perihal',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.perihalSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Dari',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.dari}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Tempat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text(widget.surat.tempat ?? "",
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Tgl Acara',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text(
                        '${dateFormat(widget.surat.tanggal)} s/d ${dateFormat(widget.surat.tanggal2)}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Jam',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.jam ?? ""} WIB',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 20.0),
            Text('Disposisi Surat',
                style: title.copyWith(
                    color: secondaryBlueBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Bidang',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi1}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Seksi',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi2}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Staff',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi3}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Keterangan Surat',
                style: title.copyWith(
                    color: secondaryBlueBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Isi',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.isiSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            widget.rulePegawai == "kadin"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text('Status',
                              style: regular.copyWith(
                                  color: secondaryBlueBlack, fontSize: 14.0),
                              textAlign: TextAlign.start)),
                      Expanded(
                          child: Text('${widget.surat.status}',
                              style: regular.copyWith(
                                  color: Colors.red.shade400,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text('Status',
                              style: regular.copyWith(
                                  color: secondaryBlueBlack, fontSize: 14.0),
                              textAlign: TextAlign.start)),
                      Expanded(
                          child: Text('${widget.surat.statusDp}',
                              style: regular.copyWith(
                                  color: widget.surat.statusDp == "proses"
                                      ? Colors.orange.shade500
                                      : Colors.green,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start)),
                    ],
                  ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Staff',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi3}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('File Surat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FileSuratDispo(
                            fileSurat: widget.surat.fileSurat!)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff367588),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8)),
                  icon: const Icon(
                    Icons.remove_red_eye,
                    size: 24.0,
                  ),
                  label: Text(
                    'Lihat Surat',
                    style: title.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
                width: 100,
                child: Text('Aksi',
                    style: title.copyWith(
                        color: secondaryBlueBlack, fontSize: 16.0),
                    textAlign: TextAlign.start)),
            const SizedBox(height: 16.0),
            Center(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceAround,
                spacing: MediaQuery.of(context).size.width * 0.20,
                runSpacing: 16,
                children: [
                  widget.rulePegawai == "staff"
                      ? Container()
                      : ElevatedButton.icon(
                          onPressed: () {
                            dispoProcess(widget.surat.statusDp);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              elevation: 0,
                              minimumSize: const Size(125, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8)),
                          icon: const Icon(
                            Icons.edit_document,
                            size: 24.0,
                          ),
                          label: Text(
                            widget.surat.statusDp == "proses"
                                ? 'Disposisi'
                                : 'Edit Disposisi',
                            style: title.copyWith(color: Colors.white),
                          ),
                        ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Terima Surat",
                                    style: title.copyWith(
                                        color: primaryBlueBlack)),
                                content: Text(
                                    'Apakah yakin menerima surat ini?',
                                    style: regular.copyWith(
                                        color: secondaryBlueBlack,
                                        fontSize: 14.0)),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: const BorderSide(
                                                color: Color(0xff355BF5))),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Batalkan',
                                        style: regular.copyWith(
                                            color: secondaryBlueBlack),
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _onLoading();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff355BF5),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text('Ya', style: regular)),
                                ],
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff355BF5),
                        elevation: 0,
                        minimumSize: const Size(125, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)),
                    icon: const Icon(
                      Icons.mark_email_read,
                      size: 24.0,
                    ),
                    label: Text(
                      'Terima Surat',
                      style: title.copyWith(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      dispoBalik();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF9900),
                        elevation: 0,
                        minimumSize: const Size(125, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)),
                    icon: const Icon(
                      Icons.refresh_rounded,
                      size: 24.0,
                    ),
                    label: Text(
                      'Dispo Balik',
                      style: title.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dispoBalik() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Konfirmasi Dispo Balik",
                style: title.copyWith(color: primaryBlueBlack, fontSize: 16.0)),
            content: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alasan wajib diisi';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Alasan Dispo Balik',
                labelStyle:
                    regular.copyWith(color: secondaryBlueBlack, fontSize: 14.0),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide:
                        BorderSide(color: Color(0xffFF9900), width: 2.0)),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: greyColor, width: 2.0),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Color(0xffFF9900),
                        )),
                    elevation: 0,
                  ),
                  child: Text(
                    'Batalkan',
                    style: regular.copyWith(color: secondaryBlueBlack),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _onLoading();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF9900),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Ya', style: regular)),
            ],
          );
        });
  }

  void sendData(String? idSurat, String? userId) async {
    if (idSurat != null && userId != null) {
      switch (widget.rulePegawai) {
        case "staff":
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses Diterima oleh Staff',
                style: regular.copyWith(fontSize: 14)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case "kasi":
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses Diterima oleh Kasi',
                style: regular.copyWith(fontSize: 14)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case "kabid":
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses Diterima oleh Kabid',
                style: regular.copyWith(fontSize: 14)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case "kadin":
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses Diterima oleh Kadin',
                style: regular.copyWith(fontSize: 14)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses Diterima oleh admin',
                style: regular.copyWith(fontSize: 14)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
      // if(widget.rulePegawai == "staff"){
      //   final snackBar = SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text('Sukses Diterima', style: regular.copyWith(fontSize: 14)),
      //   );
      //   if(!mounted) return;
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }

    // var response = await networkRepo.getTerimaStaffResponse(idSurat, userId);
    // if(response.success == 1){
    //   final snackBar = SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Text('Sukses Diterima', style: regular.copyWith(fontSize: 14)),
    //   );
    //   if(!mounted) return;
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  void dispoProcess(String? proses) {
    print("bidang : $bidang seksi: $seksi");
    if (proses == "proses") {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Center(
                  child: Text("Menu Disposisi",
                      style: title.copyWith(
                          color: primaryBlueBlack, fontSize: 16.0))),
              backgroundColor: white,
              scrollable: true,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Tujuan Disposisi",
                      style: title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: FutureBuilder(
                          future: networkRepo.getItemDisposisi(
                              widget.rulePegawai, bidang!, seksi!),
                          builder: (context, snapshot) {
                            print("data : ${snapshot.data}");
                            if (snapshot.hasData) {
                              var data = snapshot.data;
                              if (data != null) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CheckboxListTile(
                                          autofocus: false,
                                          activeColor: Colors.red.shade500,
                                          checkColor: Colors.red.shade500,
                                          selected: selected,
                                          value: selected,
                                          onChanged: (value) {
                                            setState(() {
                                              selected = value!;
                                            });
                                          },
                                          title: Text(
                                            "${data[index].nama}",
                                            style: regular.copyWith(
                                                fontSize: 14.0),
                                          ));
                                    });
                              } else {
                                return Container();
                              }
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red.shade500));
                            }
                          }),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Isi Disposisi",
                      style: title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Isi Disposisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Colors.red.shade500, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: greyColor, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 0,
                      ),
                      child: Text(
                        'Kirim Disposisi',
                        style: regular.copyWith(color: white),
                      )),
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Center(
                  child: Text("Menu Disposisi",
                      style: title.copyWith(
                          color: primaryBlueBlack, fontSize: 16.0))),
              backgroundColor: white,
              scrollable: true,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Tujuan Disposisi",
                      style: title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: FutureBuilder(
                          future: networkRepo.getItemDisposisi(
                              widget.rulePegawai, bidang!, seksi!),
                          builder: (context, snapshot) {
                            print("data : ${snapshot.data}");
                            if (snapshot.hasData) {
                              var data = snapshot.data;
                              if (data != null) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CheckboxListTile(
                                          value: dispoSelected
                                              .contains(data[index].nama),
                                          onChanged: (val) {},
                                          title: Text(
                                            "${data[index].nama}",
                                            style: regular.copyWith(
                                                fontSize: 14.0),
                                          ));
                                    });
                              } else {
                                return Container();
                              }
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red.shade500));
                            }
                          }),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Isi Disposisi",
                      style: title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Isi Disposisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Colors.red.shade500, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: greyColor, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 0,
                      ),
                      child: Text(
                        'Kirim Disposisi',
                        style: regular.copyWith(color: white),
                      )),
                ),
              ],
            );
          });
    }
  }
}

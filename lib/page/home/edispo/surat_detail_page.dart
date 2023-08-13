import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/file_surat_dispo.dart';
import 'package:my_darling_app/repository/model/item_dispoisisi_response.dart';
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

  TextEditingController isiDispoBalikController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<String> dispoIdSelect = [];
  List<bool?> dispoSelect = [];
  List<ItemDisposisi> allItemDispo=[];
  List<ItemDisposisi> editItemDispo=[];
  late final ValueChanged<List<String>> onSelectIdChanged;

  String? userId = "0";
  String? bidang = '';
  String? seksi = '';
  String? isi_dp = '';

  bool isSelected = false;
  final selectedIndex = [];

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
  Future<List<ItemDisposisi>> getAllDispoSisi() async{
    final bidangDispo = await sessionManager.getBidang("bidang");
    final seksiDispo = await sessionManager.getBidang("seksi");
    var response = await networkRepo.getItemDisposisi(widget.rulePegawai, bidangDispo!, seksiDispo!);
    allItemDispo = response;
    print("Data Dispo $allItemDispo");
    return allItemDispo;
  }

  Future<List<ItemDisposisi>> getAllEditDispoSisi() async{
    final idSurat = widget.surat.idSurat;
    var response = await networkRepo.getItemEditDisposisi(idSurat!, widget.rulePegawai);
    editItemDispo = response;
    print("Data DispoEdit");
    return editItemDispo;
  }

  @override
  void initState() {
    super.initState();
    isiDispoBalikController.clear();
    getIdUser();
    getIdBidang();
    getIdSeksi();
    getAllDispoSisi();
    getAllEditDispoSisi();
  }

  void _onLoading(String status) {
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
      Navigator.pop(context); 
      //pop dialog
      if(status == "dispoBalik"){
        String isiDispoBalik = isiDispoBalikController.text;
        String rule = widget.rulePegawai;
        final bidangDispo = bidang;
        final seksiDispo = seksi;
        if(bidangDispo != null && seksiDispo !=null && userId != null){
          sendDispoBalik(widget.surat.idSurat, isiDispoBalik, rule, bidangDispo, seksiDispo, userId!);
        }

        print("Ini Tombol Dispo Balik dan isinya $isiDispoBalik");
        
      }
      else if(status == "terimaSurat"){
        print("Ini Tombol Terima Surat");
        sendData(widget.surat.idSurat, userId, bidang, seksi);
      }
     
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
                                        _onLoading("terimaSurat");
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
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: isiDispoBalikController,
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
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    isiDispoBalikController.clear();
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
                    if(_formKey.currentState!.validate()){
                      String isiDispoBalik = isiDispoBalikController.text;
                      Navigator.pop(context);
                      _onLoading("dispoBalik");
                      print("isiDipsoBalik : $isiDispoBalik");
                    }

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

  void sendData(String? idSurat, String? userId, String? bidang, String? seksi) async {
    if (idSurat != null && userId != null && bidang!= null && seksi !=null) {
      switch (widget.rulePegawai) {
        case "staff":
          getResponseTerimaSurat("staff", idSurat, userId);
          break;
        case "kasi":
          getResponseTerimaSurat("kasi", idSurat, userId, bidang, seksi);
          break;
        case "kabid":
          getResponseTerimaSurat("kabid", idSurat, userId, bidang);
          break;
        case "kadin":
          getResponseTerimaSurat("kabid", idSurat, userId, bidang);
          break;
      }
    }
  }

  void dispoProcess(String? proses) {
    if (kDebugMode) {
      print("bidang : $bidang seksi: $seksi");
    }
    if (proses == "proses") {
      showDialog(
          context: context,
          builder: (_) {
            return DialogDispo(
                dispoList: allItemDispo,
                selectedId: dispoIdSelect,
                idSurat: widget.surat.idSurat,
                onSelectedId: (dispoSelect){
                  dispoIdSelect = dispoSelect;
                  print(dispoSelect);
                }
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return DialogDispo(
                dispoList: allItemDispo,
                selectedId: dispoIdSelect,
                idSurat: widget.surat.idSurat,
                editDispoList: editItemDispo,
                onSelectedId: (dispoSelect){
                  dispoIdSelect = dispoSelect;
                  print(dispoSelect);
                }
            );
          });
    }
  }
  //buat nerima surat
  void getResponseTerimaSurat(String rule, String idSurat, String userId, [String? bidang, String? seksi]) async {
    if(rule == "staff"){
      var responseTerima = await networkRepo.getTerimaStaffResponse(idSurat, userId);
      if(responseTerima.success == 1){
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Sukses Diterima oleh Staff',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Gagal Diterima oleh Staff',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else if(rule == "kasi"){
      var responseTerima = await networkRepo.getTerimaKasiResponse(idSurat, userId, bidang!, seksi!);
      if(responseTerima.success == 1){
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Sukses Diterima oleh Kasi',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Gagal Diterima oleh Kasi',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else if(rule == "kabid"){
      var responseTerima = await networkRepo.getTerimaKabidResponse(idSurat, userId, bidang!);
      if(responseTerima.success == 1){
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Sukses Diterima oleh Kabid',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Gagal Diterima oleh Kabid',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else if(rule == "kadin"){
      var responseTerima = await networkRepo.getTerimaKadinResponse(idSurat, userId, bidang!);
      if(responseTerima.success == 1){
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Sukses Diterima oleh Kadin',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Gagal Diterima oleh Kadin',
              style: regular.copyWith(fontSize: 14)),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
  //buat dispobalik
  void sendDispoBalik(String? idSurat, String isiDispoBalik, String rulePegawai, String bidang, String seksi, String userId) async{
    var response = await networkRepo.getDispoBalikResponse(idSurat!, isiDispoBalik, rulePegawai, bidang, seksi, userId);
    if(response.success == 1){
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Sukses Dispo Balik',
            style: regular.copyWith(fontSize: 14)),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      isiDispoBalikController.clear();
    }
    else{
      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Gagal Dispo Balik',
            style: regular.copyWith(fontSize: 14)),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class DialogDispo extends StatefulWidget {
  final List<ItemDisposisi> dispoList;
  final List<ItemDisposisi>? editDispoList;
  final List<String> selectedId;
  final ValueChanged<List<String>> onSelectedId;
  final String? idSurat;

  const DialogDispo({super.key, required this.dispoList, required this.selectedId, required this.onSelectedId, required this.idSurat, this.editDispoList});

  @override
  State<DialogDispo> createState() => _DialogDispoState();
}

class _DialogDispoState extends State<DialogDispo> {
  List<String> _tempSelectedId =[];
  final sessionManager = SessionManager();
  final networkRepo = NetworkRepo();

  TextEditingController isiDispoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSelected = false;
  String? userId = "";
  String? bidang = "";
  String? seksi = "";
  String? rule = "";
  String? disposisi="";

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

  Future<String?> getIdRule() async {
    rule = await sessionManager.getRule("rule");
    return rule;
  }

  @override
  void initState() {
    _tempSelectedId = widget.selectedId;
    getIdBidang();
    getIdSeksi();
    getIdRule();
    getIdUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Center(
              child: Text("Menu Disposisi",
                  style: title.copyWith(
                      color: primaryBlueBlack, fontSize: 16.0))),
          backgroundColor: white,
          scrollable: true,
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                    child:ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.dispoList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            "${widget.dispoList[index].nama}",
                            style:
                            regular.copyWith(fontSize: 14.0),
                          ),
                          trailing: Checkbox(
                            activeColor: Colors.red.shade500,
                            checkColor: white,
                            value: _tempSelectedId.contains(widget.dispoList[index].id),
                            onChanged: (value) {
                              if(value != null){
                                if (kDebugMode) {
                                  print(value);
                                }
                                if(value){
                                  if(widget.editDispoList != null){
                                    if(widget.editDispoList?[index].id == widget.dispoList[index].id){
                                      setState((){
                                        _tempSelectedId.add(widget.editDispoList![index].id!);
                                      });
                                    }
                                  }
                                  if(!_tempSelectedId.contains(widget.dispoList[index].id)){
                                    setState(() {
                                      _tempSelectedId.add(widget.dispoList[index].id!);
                                      final idSelect =[];
                                      for(var dispoItem in _tempSelectedId){
                                        var concatenate = StringBuffer();
                                        concatenate.write('"$dispoItem"');
                                        idSelect.add(concatenate);
                                      }
                                      disposisi = idSelect.toString();
                                      print("data id terpilih: $disposisi");
                                    });
                                  }
                                  else{
                                    setState(() {
                                      _tempSelectedId.removeWhere((String id) => id == (widget.dispoList[index].id!));
                                    });
                                  }
                                }
                                else{
                                  setState(() {
                                    _tempSelectedId.removeWhere((String id) => id == (widget.dispoList[index].id!));
                                  });

                                }
                                widget.onSelectedId(_tempSelectedId);
                              }
                            },
                          ),
                        );
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
                    controller: isiDispoController,
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
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    if (_formKey.currentState!.validate()) {
                      String isiDispo = isiDispoController.text;
                      doDisposisi(widget.idSurat, disposisi, isiDispo, rule, bidang, seksi, userId);
                      // _networkRepo.doLogin(email, password);
                    }

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
      }
    );
  }

  void doDisposisi(String? idSurat, String? disposisi, String isiDispo, String? rule, String? bidang, String? seksi, String? userId) async{
    var response = await networkRepo.getDispoResponse(idSurat!, disposisi!, isiDispo, rule!, bidang!, seksi!, userId!);
    if(response.success == 1){
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Sukses Disposisi',
            style: regular.copyWith(fontSize: 14)),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Gagal Disposisi',
            style: regular.copyWith(fontSize: 14)),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}


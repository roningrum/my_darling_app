import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class AkmRiwayatWidget extends StatefulWidget {
  final String nik;

  const AkmRiwayatWidget({super.key, required this.nik});

  @override
  State<AkmRiwayatWidget> createState() => _AkmRiwayatWidgetState();
}

class _AkmRiwayatWidgetState extends State<AkmRiwayatWidget> {
  final networkRepo = NetworkRepo();
  bool isLoading = false;

  void startTimer(){
    Timer.periodic(const Duration(seconds: 5), (t){
      setState(() {
        isLoading = false;
      });
      t.cancel();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        scanBarcodeAKM(),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget scanBarcodeAKM() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(width: 3, color: const Color(0xffe1e1e1)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: primaryBlueBlack,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Klik disini untuk scan barcode',
                    style: title.copyWith(fontSize: 16.0, color: white)),
                SvgPicture.asset('assets/icons/qrcode.svg',
                    width: 45.0, height: 45.0)
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
              'Data Checkup Kesehatan (Menggunakan Mesin Anjungan Kesehatan Mandiri',
              style: regular.copyWith(fontSize: 14.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 32.0),
          FutureBuilder(
              future: networkRepo.getDataCheckupTerakhir(widget.nik),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Berat Badan", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/weight.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("${snapshot.data![0].berat}Kg", style: regular.copyWith(fontSize: 14.0)),
                            Text(dateFormat(snapshot.data![0].tglCekBerat!), style: regular.copyWith(fontSize: 12.0)),
                            TextButton(onPressed: (){
                              showModalBottomSheet(context: context, builder: (context){
                                return Column(
                                  children: [
                                    const SizedBox(height: 16.0),
                                    Text('Riwayat Berat Badan', style: title.copyWith(fontSize: 16.0)),
                                    const SizedBox(height: 18.0),
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Tanggal Periksa", style: regular.copyWith(fontSize: 14)),
                                          const SizedBox(width: 8.0),
                                          Text("Berat Badan", style: regular.copyWith(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    daftarRiwayatBeratBadan()
                                  ],
                                );

                              });
                            }, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Column(
                          children: [
                            Text("Tinggi Badan", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/body.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("${snapshot.data![0].tinggi}cm", style: regular.copyWith(fontSize: 14.0)),
                            Text(dateFormat(snapshot.data![0].tglCekTinggi!), style: regular.copyWith(fontSize: 12.0)),
                            TextButton(onPressed: (){
                              showModalBottomSheet(context: context, builder: (context){
                                return Column(
                                  children: [
                                    const SizedBox(height: 16.0),
                                    Text('Riwayat Tinggi Badan', style: title.copyWith(fontSize: 16.0)),
                                    const SizedBox(height: 18.0),
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Tanggal Periksa", style: regular.copyWith(fontSize: 14)),
                                          const SizedBox(width: 8.0),
                                          Text("Tinggi Badan", style: regular.copyWith(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    daftarRiwayatTinggiBadan()
                                  ],
                                );

                              });
                            }, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600))),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Hasil Tensi", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/blood_pressure.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("${snapshot.data![0].sistol}mm/${snapshot.data![0].diastol}Hg", style: regular.copyWith(fontSize: 14.0)),
                            Text(dateFormat(snapshot.data![0].tglCekTensi!), style: regular.copyWith(fontSize: 12.0)),
                            TextButton(onPressed: (){
                              showModalBottomSheet(context: context, builder: (context){
                                return Column(
                                  children: [
                                    const SizedBox(height: 16.0),
                                    Text('Riwayat Tensi', style: title.copyWith(fontSize: 16.0)),
                                    const SizedBox(height: 18.0),
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Tanggal Periksa", style: regular.copyWith(fontSize: 14)),
                                          const SizedBox(width: 8.0),
                                          Text("Hasil Tensi", style: regular.copyWith(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                   daftarRiwayatTensi()
                                  ],
                                );

                              });
                            }, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)) )
                          ],
                        ),
                      ],
                    );
                  }
                  else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Berat Badan", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/weight.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("Belum Periksa", style: regular.copyWith(fontSize: 14.0)),
                            TextButton(onPressed: (){}, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Column(
                          children: [
                            Text("Tinggi Badan", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/body.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("Belum Periksa", style: regular.copyWith(fontSize: 14.0)),
                            TextButton(onPressed: (){}, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)) )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Hasil Tensi", style: regular.copyWith(fontSize: 14.0)),
                            const SizedBox(height: 8.0),
                            SvgPicture.asset("assets/icons/blood_pressure.svg",
                                width: 60, height: 60),
                            const SizedBox(height: 8.0),
                            Text("${snapshot.data![0].sistol}mm/${snapshot.data![0].diastol}Hg", style: regular.copyWith(fontSize: 14.0)),
                            TextButton(onPressed: (){}, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)) )
                          ],
                        ),
                      ],
                    );
                  }
                }
                else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                  return Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text("Cek Koneksi Kembali",
                          style: regular.copyWith(
                              fontSize: 14.0, color: secondaryBlueBlack)),
                    ),
                  );
                }
                else{
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: primaryRed));
                }
              }),
        ],
      ),
    );
  }

  Widget daftarRiwayatBeratBadan() {
    return FutureBuilder(
        future: networkRepo.getBeratBadanTerakhir(widget.nik),
        builder:(context, snapshot){
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                          "Saat ini belum ada catatan terekam",
                          style: regular.copyWith(
                              fontSize: 14.0,
                              color: secondaryBlueBlack)),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(dateFormat(snapshot.data![index].tglCekBerat), style: regular.copyWith(fontSize: 14)),
                          const SizedBox(width: 8.0),
                          Text("${snapshot.data![index].berat} kg", style: regular.copyWith(fontSize: 14)),
                        ]
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SvgPicture.asset("assets/icons/no_data.svg", width: 120, height: 120,),
                  const SizedBox(height: 8.0),
                  Text("Tidak ada Riwayat yg terekam",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                ],
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: primaryRed));
          }
        }
    );
  }
  Widget daftarRiwayatTinggiBadan() {
    return FutureBuilder(
        future: networkRepo.getTinggiBadanTerakhir(widget.nik),
        builder:(context, snapshot){
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                          "Saat ini belum ada catatan terekam",
                          style: regular.copyWith(
                              fontSize: 14.0,
                              color: secondaryBlueBlack)),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(dateFormat(snapshot.data![index].tglCekTinggi), style: regular.copyWith(fontSize: 14)),
                            const SizedBox(width: 8.0),
                            Text("${snapshot.data![index].tinggi} cm", style: regular.copyWith(fontSize: 14)),
                          ]
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SvgPicture.asset("assets/icons/no_data.svg", width: 120, height: 120,),
                  const SizedBox(height: 8.0),
                  Text("Tidak ada Riwayat yg terekam",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                ],
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: primaryRed));
          }
        }
    );
  }
  Widget daftarRiwayatTensi() {
    return FutureBuilder(
        future: networkRepo.getHistoryTensiTerakhir(widget.nik),
        builder:(context, snapshot){
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                          "Saat ini belum ada catatan terekam",
                          style: regular.copyWith(
                              fontSize: 14.0,
                              color: secondaryBlueBlack)),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(dateFormat(snapshot.data![index].tglCekTensi), style: regular.copyWith(fontSize: 14)),
                            const SizedBox(width: 8.0),
                            Text("${snapshot.data![index].sistol} mm / ${snapshot.data![index].diastol} Hg", style: regular.copyWith(fontSize: 14)),
                          ]
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SvgPicture.asset("assets/icons/no_data.svg", width: 120, height: 120,),
                  const SizedBox(height: 8.0),
                  Text("Tidak ada Riwayat yg terekam",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                ],
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: primaryRed));
          }
        }
    );
  }
}

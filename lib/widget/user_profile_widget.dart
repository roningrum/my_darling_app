import 'package:flutter/material.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/akm_riwayat_profile.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({Key? key, required this.userId, required this.nik})
      : super(key: key);

  final String userId;
  final String nik;

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final networkRepo = NetworkRepo();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: FutureBuilder(
          future: networkRepo.getUserProfile(widget.userId),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data != null) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('Nama',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('${data[0].nama}',
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.verified_user, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('username',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('${data[0].username}',
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.email, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('email',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(data[0].email ?? "tidak ada email",
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.badge, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('NIK',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('${data[0].nik}',
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.work, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('Status',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('${data[0].rule}',
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.face, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('Jenis Kelamin',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                        data[0].jenisKelamin == "P" ? "Perempuan" : "Laki-Laki",
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.phone_outlined, color: secondaryBlueBlack),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text('Kontak',
                            style: title.copyWith(
                                fontSize: 14, color: secondaryBlueBlack))
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text("${data[0].telp}",
                        style: regular.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                    const SizedBox(height: 16.0),
                    rekamanKesehatan(),
                    const SizedBox(height: 16.0),
                    rekamanKesehatanAKM(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator(color: primaryRed));
            }
          }),
    );
  }

  Widget rekamanKesehatan() {
    return FutureBuilder(
        future: networkRepo.getCatatanKesehatan(widget.nik),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null && data.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: secondaryBlueBlack),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text('Catatan Kesehatan Pribadi',
                        style: title.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                  ],
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length, itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tinggi Badan',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].tb} cm',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Berat Badan',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].bb} kg',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lingkar Pinggang',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].lp} cm',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tekanan darah',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].sistole}/${data[index].diastole} mmHg',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gula Darah',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].gulaDarah}',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Index Masa Tubuh',
                                        style: title.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                    const SizedBox(height: 8.0),
                                    Text('${data[index].imt}',
                                        style: regular.copyWith(
                                            fontSize: 14, color: secondaryBlueBlack)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                }),

              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.person, color: secondaryBlueBlack),
                    const SizedBox(width: 8.0),
                    Text('Catatan Kesehatan Pribadi',
                        style: title.copyWith(
                            fontSize: 14, color: secondaryBlueBlack)),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text('Belum ada catatan kesehatan',
                    style: regular.copyWith(
                        fontSize: 14, color: secondaryBlueBlack)),
              ],
            );
          }
        });
  }

  Widget rekamanKesehatanAKM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, color: secondaryBlueBlack),
            const SizedBox(
              width: 12.0,
            ),
            Text('Riwayat Kesehatan AKM',
                style: title.copyWith(
                    fontSize: 14, color: secondaryBlueBlack)),
          ],
        ),
        AkmRiwayatWidget(nik: widget.nik)
      ],
    );
  }
}

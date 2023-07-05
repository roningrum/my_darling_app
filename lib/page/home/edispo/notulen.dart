import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/page/home/edispo/notulen_detail.dart';
import 'package:my_darling_app/repository/model/Item_notulen_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/widget/edispo/notulen_item.dart';

import '../../../theme/theme.dart';

class Notulen extends StatefulWidget {
  final String userId;
  const Notulen({Key? key, required this.userId}) : super(key: key);

  @override
  State<Notulen> createState() => _NotulenState();
}

class _NotulenState extends State<Notulen> {
  final networkRepo = NetworkRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notulen',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              Text('Daftar Notulen Saat ini', style: title.copyWith(color: secondaryBlueBlack, fontSize: 16.0)),
              const SizedBox(height: 10.0),
              FutureBuilder<List<ItemNotulen>>(
                  future: networkRepo.getNotulen("191"),
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
                              return GestureDetector(
                                  onTap: ()=> Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          NotulenDetail(notulen: data[index]))),
                                  child: NotulenItem(notulen: data[index]));
                            }),
                          );
                        }
                      }
                    }
                    else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height,
                          alignment: Alignment.topCenter,
                          child: CircularProgressIndicator(color: primaryRed,));
                    }
                  })

            ],
          ),
        ),
      )
    );
  }

  Widget dataNoFoundWidget() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/no_data.svg', height: 100, width: 100),
          const SizedBox(height: 24),
          Text(
            'Tidak ada Notulen ditemukan',
            style: regular.copyWith(
                color: secondaryBlueBlack, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

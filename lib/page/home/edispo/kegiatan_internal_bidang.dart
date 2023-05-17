import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../repository/bidang_response.dart';
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
      appBar: AppBar(
        title: Text('Kegiatan Internal',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                daftarBidang(),
                searchByTanggal(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget daftarBidang() {
    return FutureBuilder<List<Bidang>>(
      future: _networkRepo.getBidang(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          if (kDebugMode) {
            print("Data $data");
          }
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: secondaryBlueBlack)),
            alignment: Alignment.topLeft,
            child: DropdownButton(
                hint: const Text('Pilih Bidang'),
                value: selectedBidang,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconSize: 32,
                underline: Container(),
                items: data.map((items) {
                  if (kDebugMode) {
                    print("Daftar Items $items");
                  }
                  return DropdownMenuItem(
                    value: items.alias,
                    child: Text('${items.alias}'),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedBidang = newValue.toString();
                  });
                }),
          );
        } else {
          return IgnorePointer(
            ignoring: true,
            child: DropdownButton(
                hint: const Text('Pilih Bidang'),
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconSize: 32,
                isExpanded: false,
                underline: Container(),
                items: [],
                onChanged: (newValue) {}),
          );
        }
      },
    );
  }

  Widget searchByTanggal() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
          controller: datePickerController,
          readOnly: true,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.5, color: secondaryBlueBlack)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: primaryRed)),
              prefixIcon: Icon(Icons.search, color: primaryRed),
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
              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
    );
  }
}

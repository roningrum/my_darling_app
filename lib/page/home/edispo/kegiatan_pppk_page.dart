import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';

class KegiatanPPPKPage extends StatefulWidget {
  const KegiatanPPPKPage({Key? key}) : super(key: key);

  @override
  State<KegiatanPPPKPage> createState() => _KegiatanPPPKPageState();
}

class _KegiatanPPPKPageState extends State<KegiatanPPPKPage> {
  TextEditingController datePickerController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePickerController.text = "";
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            searchByTanggal(),
          ],
        ),
      ),
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

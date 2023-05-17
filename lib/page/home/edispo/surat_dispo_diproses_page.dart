import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratDispoDiproses extends StatefulWidget {
  final String keteranganProses;
  const SuratDispoDiproses({Key? key, required this.keteranganProses}) : super(key: key);

  @override
  State<SuratDispoDiproses> createState() => _SuratDispoDiprosesState();
}

class _SuratDispoDiprosesState extends State<SuratDispoDiproses> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateinput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 12.0),
         Text('Surat ${widget.keteranganProses} pada tanggal ${getTodayDate()}', style: title.copyWith(color: secondaryBlueBlack, fontSize: 16.0), textAlign: TextAlign.center,),
          const SizedBox(height: 16.0),
          widget.keteranganProses == "Sudah Diproses"? suratDiproses():Text("Belum Ada")
        ],
      ),
    );
  }

  Widget suratDiproses(){
    return Column(
      children: [
        TextField(
          controller:dateinput,
          readOnly: true,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width:1.5, color: secondaryBlueBlack)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(width:1.5, color: primaryRed)),
              prefixIcon: Icon(Icons.search, color: primaryRed),
              label: Text('Cari tanggal', style: regular.copyWith(color: secondaryBlueBlack),)),
          onTap: () async{
            DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
            if(pickedDate !=null){
              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
              print(formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                dateinput.text = formattedDate; //set output date to TextField value.
              });
            }
            else{
              print("Date is not selected");
            }
          }),
      ],
    );
  }

  String getTodayDate(){
    var date = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');
    var todayDay = dateFormat.format(date);
    return todayDay;
  }
}

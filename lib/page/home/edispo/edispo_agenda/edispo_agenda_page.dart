import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/model/agenda_surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/agenda_today_item.dart';


class EdispoAgendaPage extends StatefulWidget {
  const EdispoAgendaPage({Key? key}) : super(key: key);

  @override
  State<EdispoAgendaPage> createState() => _EdispoAgendaPageState();
}

class _EdispoAgendaPageState extends State<EdispoAgendaPage> {
  final networkRepo = NetworkRepo();
  final bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Agenda Hari Ini', style: regular.copyWith(color: secondaryBlueBlack, fontWeight: FontWeight.w600),),
              TextButton.icon(
                onPressed:(){},
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                      if(states.contains(MaterialState.pressed)){
                        return const Color(0xffF5D2D2).withOpacity(0.25);
                      }
                      return null;
                    })
                ),
                label: Text('Cari Agenda', style: regular.copyWith(color: primaryRed, fontWeight: FontWeight.w600)),
                icon: const Icon(
                  Icons.search,
                  size: 24.0,
                  color: Color(0xffD72323),
                ),
              )
            ],
          ),
          FutureBuilder<List<Data>>(
            future: networkRepo.getAgenda(getTodayDate(), getTodayDate()),
            builder: (context, snapshot){
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isNotEmpty){
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length ,
                    itemBuilder: (context, index){
                      var data = snapshot.data![index];
                      return AgendaTodayItem(data: data);
                    },
                  );
                }
                else{
                  return Center(
                    child: Text("Tidak ada Agenda hari ini",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                }
              }
              else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                return Center(
                  child: Text("Cek Koneksi Kembali",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                );
              }
              else{
                return Container();
              }
            },
          ),
          const SizedBox(height: 24)

        ],
      ),
    );
  }
}

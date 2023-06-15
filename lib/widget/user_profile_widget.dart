import 'package:flutter/material.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    final networkRepo = NetworkRepo();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: networkRepo.getUserProfile(userId),
        builder: (context, snapshot){
          var data = snapshot.data;
          if(data!=null){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: secondaryBlueBlack),
                    const SizedBox(width: 12.0,),
                    Text('Nama', style: title.copyWith(fontSize: 14, color: secondaryBlueBlack))
                  ],
                ),
                const SizedBox(height: 8.0,),
                Text('${data[0].nama}', style: title.copyWith(fontSize: 14, color: secondaryBlueBlack)),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person, color: secondaryBlueBlack),
                    const SizedBox(height: 12.0,),
                    Text('NIK', style: title.copyWith(fontSize: 14, color: secondaryBlueBlack))
                  ],
                ),
                const SizedBox(height: 8.0),
                Text('${data[0].nik}', style: title.copyWith(fontSize: 14, color: secondaryBlueBlack)),
              ],
            );
          }
          else{
            return Container();
          }

        }
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/model/login_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();
  late String token;
  String? userId;
  late String urlPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:  [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            title: Text('Profil Pengguna', style: regular.copyWith(color: Colors.white, fontSize: 16.0)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: primaryBlueBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 72.0),
                    Image.asset('assets/image/user-photo.png', width: 70, height: 70,),
                    const SizedBox(height: 16.0),
                    Text('Erina', style: title.copyWith(color: Colors.white, fontSize: 16.0)),
                    const SizedBox(height: 16.0),
                    Text('NIP: 3725689000', style: regular.copyWith(color: Colors.white, fontSize: 16.0)),

                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

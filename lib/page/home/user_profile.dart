import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/login_screen.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/user_profile_widget.dart';

class UserProfile extends StatefulWidget {
  final String userId;
  const UserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _networkRepo = NetworkRepo();
  late String token;
  late String urlPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _networkRepo.getUserProfile(widget.userId),
        builder: (context, snapshot){
          var data = snapshot.data;
          if(data != null){
            return CustomScrollView(
              slivers:  [
                SliverLayoutBuilder(
                  builder: (context, constraints){
                    final scrolled = constraints.scrollOffset > 0;
                    return SliverAppBar(
                      backgroundColor: scrolled ? primaryBlueBlack : secondaryBlueBlack,
                      pinned: true,
                      actions: [
                        IconButton(onPressed: (){
                          logout();
                        }, icon: const Icon(Icons.logout_rounded, color: Colors.white,))
                      ],
                      expandedHeight: 200.0,
                      title: Text('Profil Pengguna', style: regular.copyWith(color: Colors.white, fontSize: 16.0)),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                           padding: const EdgeInsets.only(top: 66.0),
                            decoration: BoxDecoration(
                                color: primaryBlueBlack
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: 'http://119.2.50.170:9095/e_dispo/assets/temp/foto/${data[0].foto}',
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 96.0,
                                    height: 96.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Image.asset(
                                    'assets/image/user-photo.png',
                                    width: 96.0,
                                    height: 96.0,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/image/user-photo.png',
                                    width: 96.0,
                                    height: 96.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text('${data[0].nama}', style: title.copyWith(color: Colors.white, fontSize: 16.0)),
                              ],
                            )
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: UserProfileWidget(userId: widget.userId, nik: data[0].nik!),
                )
              ],
            );
          }
          else{
            return CustomScrollView(
              slivers:  [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 280.0,
                  title: Text('Profil Pengguna', style: regular.copyWith(color: Colors.white, fontSize: 16.0)),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Container(
                        decoration: BoxDecoration(
                            color: primaryBlueBlack
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 60.0),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/blank-profile-picture-973460_640.png',

                              ),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle
                          ),
                        ),
                            const SizedBox(height: 8.0),
                            Text('', style: title.copyWith(color: Colors.white, fontSize: 16.0)),
                            const SizedBox(height: 8.0),
                            Text('', style: regular.copyWith(color: Colors.white, fontSize: 16.0)),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            );
          }
        }
      )
    );
  }

  void logout(){
    var sessionManager = SessionManager();
    sessionManager.clear();
    Hive.deleteBoxFromDisk('steps');
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
    // Hive.close();
  }
}

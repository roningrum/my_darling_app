import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/profil_tab_view.dart';
import 'package:my_darling_app/status_tab_view.dart';

import 'const.dart';

class ProfilTabScreen extends StatefulWidget {
  const ProfilTabScreen({Key? key}) : super(key: key);

  @override
  _ProfilTabScreenState createState() => _ProfilTabScreenState();
}

class _ProfilTabScreenState extends State<ProfilTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxScrolled){
            return [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: primaryColor,
                expandedHeight: 250,
                pinned: true,
                floating: false,
                title: Text('ProfilKu', style: titleText.copyWith(color:whiteColor, fontSize: 18 )),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 64),
                      Image.asset('assets/images/foto.png', width: 72),
                      SizedBox(height: 16),
                      Text('John Slamet', style: titleText.copyWith(color: whiteColor, fontSize: 16)),
                      SizedBox(height: 8),
                      Text('NIP 312345600987', style: titleText.copyWith(color: whiteColor, fontWeight:FontWeight.w400, fontSize: 12))
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: const[
                      Tab(
                        icon: Icon(Icons.person),
                        text: 'MyProfil',
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        icon: Icon(Icons.badge),
                        iconMargin: EdgeInsets.zero,
                        text: 'Status',
                        // child: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     SvgPicture.asset('assets/images/icons/badge.svg', width: 24.0,color:primaryColor),
                        //     SizedBox(width: 8),
                        //
                        //   ],
                        // ),
                      ),
                    ],
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: primaryColor
                    ),

                    indicatorColor: primaryColor,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor: whiteColor,
                    unselectedLabelStyle: titleText.copyWith(fontSize: 14),
                    unselectedLabelColor: primaryColor,
                    labelStyle: subtitleTextStyle.copyWith(fontSize: 14),
                  ),
                ),

              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const[
              ProfilTabView(),
              StatusTabView()
            ],
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate{

  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
   return Container(
     color: whiteColor,
     padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
     child: _tabBar,
   );
  }


  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
   return false;
  }
}

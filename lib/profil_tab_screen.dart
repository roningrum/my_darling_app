import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'const.dart';

class ProfilTabScreen extends StatefulWidget {
  const ProfilTabScreen({Key? key}) : super(key: key);

  @override
  _ProfilTabScreenState createState() => _ProfilTabScreenState();
}

class _ProfilTabScreenState extends State<ProfilTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
      print("Index Selected"+ _tabController.index.toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled){
            return [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: primaryColor,
                expandedHeight: 250,
                pinned: true,
                title: Text('ProfilKu', style: titleText.copyWith(color:whiteColor, fontSize: 18 )),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Image.asset('assets/images/foto.png', width: 72),
                      SizedBox(height: 16),
                      Text('John Slamet', style: titleText.copyWith(color: whiteColor, fontSize: 16),)
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(delegate: _SliverAppBarDelegate(
                TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: primaryColor
                    ),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person,size:24),
                            SizedBox(width: 8),
                            Text('Profil',style: bodyTextStyle.copyWith(color: _tabController.index==0? whiteColor : primaryColor))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/images/icons/badge.svg', width: 24.0,color:  _tabController.index==1?whiteColor:primaryColor),
                            SizedBox(width: 8),
                            Text('Status',style: bodyTextStyle.copyWith(color: _tabController.index==1?whiteColor:primaryColor))
                          ],
                        ),
                      ),
                    ],
                    controller: _tabController),
              ),
                pinned: true
              )
            ];
          },
          body: Center(
            child: Text('Sample Text'),
          ),
        ),
      ),
    ));
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
     margin: EdgeInsets.only(top: 8, left: 24, right: 24),
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

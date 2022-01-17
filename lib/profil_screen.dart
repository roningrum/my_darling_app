import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/const.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color indicator = primaryColor;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text('ProfilKu',
              style: titleText.copyWith(fontSize: 16, color: whiteColor)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 204,
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Image.asset('assets/images/foto.png', width: 72),
                  SizedBox(height: 16),
                  Text('John Slamet',
                      style:
                          titleText.copyWith(fontSize: 18, color: whiteColor)),
                  SizedBox(height: 8),
                  Text('NIP 325000000',
                      style:
                          titleText.copyWith(fontSize: 14, color: whiteColor)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: 54,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: TabBar(
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person,size:24),
                          SizedBox(width: 8),
                          Text('Profil',style: bodyTextStyle.copyWith(color: _tabController.index == 0 ?  whiteColor : primaryColor))
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/icons/badge.svg', width: 24.0,color: _tabController.index == 1 ?  whiteColor : primaryColor),
                          SizedBox(width: 8),
                          Text('Status',style: bodyTextStyle.copyWith(color: _tabController.index == 1 ?  whiteColor : primaryColor))
                        ],
                      ),
                    ),
                  ],
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: indicator
                  ),
                  unselectedLabelColor: primaryColor,
                  controller: _tabController,
                  labelColor: Colors.white),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(
                      child: Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // second tab bar view widget
                    Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}

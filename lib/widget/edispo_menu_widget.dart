import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:my_darling_app/theme/theme.dart';

class EdispoMenuWidget extends StatefulWidget {
  final String namaMenu;
  final String logoMenu;
  final int totalSurat;

  const EdispoMenuWidget(this.namaMenu, this.logoMenu,
      {Key? key, required this.totalSurat})
      : super(key: key);

  @override
  State<EdispoMenuWidget> createState() => _EdispoMenuWidgetState();
}

class _EdispoMenuWidgetState extends State<EdispoMenuWidget> {
  late bool _showBadge;

  @override
  Widget build(BuildContext context) {
    _showBadge = widget.totalSurat >1 ? true : false;

    return SizedBox(
      width: 105,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                badgeAnimation: const badges.BadgeAnimation.fade(
                    disappearanceFadeAnimationDuration:
                        Duration(seconds: 2)),
                badgeContent: Text("${widget.totalSurat}", style: regular.copyWith(color: Colors.white, fontSize: 11),),
                showBadge: _showBadge,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    widget.logoMenu,
                    width: 32.0,
                    height: 32.0,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          const SizedBox(height: 4),
          Text(
            widget.namaMenu,
            style: regular.copyWith(fontSize: 12.0, color: secondaryBlueBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

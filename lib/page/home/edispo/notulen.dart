import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class Notulen extends StatefulWidget {
  const Notulen({Key? key}) : super(key: key);

  @override
  State<Notulen> createState() => _NotulenState();
}

class _NotulenState extends State<Notulen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notulen',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Container()
    );
  }
}

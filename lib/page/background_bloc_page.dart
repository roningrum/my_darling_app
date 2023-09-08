import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_darling_app/bloc/background_state.dart';

import '../bloc/background_bloc.dart';


class BackgroundBlocPage extends StatelessWidget {
  const BackgroundBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => BackgroundBloc(isRunning: true),
    child: BlocBuilder<BackgroundBloc, BackgroundState>(builder: (BuildContext context, BackgroundState state) => _builPage(context)),
    );
  }

  Widget _builPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: const Text("Teks"),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/homepagecubit.dart';
import '../../viewmodel/homepagestate.dart';

class SingleOrder extends StatelessWidget {
  final int? id;
   SingleOrder({this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = HomePageCubit.get(context);
      return Scaffold(

      );
    });
  }
}

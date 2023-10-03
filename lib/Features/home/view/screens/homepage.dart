import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: CustomColors.primarycolor,
            items: cubit.items,
            index: cubit.currentindex,
            height: 50.h,
            onTap: (currentindex) => cubit.changecurrentindex(currentindex),
          ),
          body: cubit.layouts[cubit.currentindex],
        );
      },
    );
  }
}

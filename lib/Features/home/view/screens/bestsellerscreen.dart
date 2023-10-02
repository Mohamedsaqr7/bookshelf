import 'package:bookshelf/Features/home/view/component/bestsellercard.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bestsellergrid extends StatelessWidget {
  const Bestsellergrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);

        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    itemCount: cubit.bestSellerModel?.sellerdata?.length??5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => Bestsellercard(
                        products: cubit.sellerdata?.products?[index]),
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

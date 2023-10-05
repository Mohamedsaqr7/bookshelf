import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/textWidgets.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              child: cubit.favomodel?.data?.dataInfo?.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.heart_broken_sharp,
                            size: 200.sp,
                            color: Colors.grey,
                          ),
                          hometext1(text: 'Nothing...!', size: 35.sp)
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return bookcard(
                              onPressed1: () {
                                cubit.removeFav(
                                    id: cubit.favomodel?.data?.dataInfo?[index]
                                            .id ??
                                        0);
                              },
                              onPressed2: () {
                                cubit.addtocart(
                                    id: cubit.favomodel?.data?.dataInfo?[index]
                                            .id ??
                                        0);
                              },
                              text1:
                                  "${cubit.favomodel?.data?.dataInfo?[index].name}",
                              text2:
                                  "${cubit.favomodel?.data?.dataInfo?[index].category}",
                              text3:
                                  "${cubit.favomodel?.data?.dataInfo?[index].price}",
                              image:
                                  "${cubit.favomodel?.data?.dataInfo?[index].image}",
                              text4: cubit.finalprice(
                                '${cubit.favomodel?.data?.dataInfo?[index].price}',
                                "${cubit.favomodel?.data?.dataInfo?[index].discount}",
                              ),
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ));
                        },
                        separatorBuilder: (context, index) => sbox(h: 10),
                        itemCount: cubit.favomodel?.data?.dataInfo?.length ?? 0,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

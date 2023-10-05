import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/screens/singleorder.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:bookshelf/x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: SizedBox(
            child: cubit.ordermodel?.data?.orders?.length == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back)),
                          sbox(w: 20),
                        ]),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 200.sp,
                          color: Colors.grey,
                        ),
                        hometext1(text: 'No history yet...!', size: 35.sp)
                      ],
                    ),
                  )
                : SafeArea(
                    child: Padding(
                    padding: EdgeInsets.all(12.0.w),
                    child: Column(
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back)),
                          sbox(w: 20),
                          hometext1(text: 'Your orders history..', size: 26),
                        ]),
                        sbox(h: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 213, 231, 236),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            255, 205, 214, 231))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: ListTile(
                                    title: hometext2(
                                        text:
                                            '${cubit.ordermodel?.data?.orders?[index].orderDate}'),
                                    trailing: IconButton(
                                        onPressed: () {
                                          cubit.getsingleorderhistory(cubit
                                              .ordermodel
                                              ?.data
                                              ?.orders?[index]
                                              .id);
                                          Navigation.gopush(
                                              context,
                                              SingleOrder(
                                                id: cubit.ordermodel?.data
                                                    ?.orders?[index].id,
                                              ));
                                        },
                                        icon: Icon(
                                            Icons.arrow_circle_right_outlined)),
                                  ),
                                )),
                            separatorBuilder: (context, index) => sbox(h: 15),
                            itemCount:
                                cubit.ordermodel?.data?.orders?.length ?? 0)
                      ],
                    ),
                  )),
          ),
        );
      },
    );
  }
}

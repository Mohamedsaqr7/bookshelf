import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/bookmodel.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Books extends StatelessWidget {
  Bookproducts? produccts;
  Books({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.searchkey,
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.search,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                  ),
                  sbox(h: 15),
                  Container(
                    height: 583,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.4))),
                              child: Padding(
                                padding: EdgeInsets.all(12.0.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    sbox(w: 12),
                                    Column(
                                      children: [
                                        hometext1(
                                            text: cubit
                                                    .bookmodel
                                                    ?.bookdata
                                                    ?.bookproducts?[index]
                                                    .name ??
                                                ' code'),
                                        sbox(h: 10),
                                        hometext2(
                                            text: cubit
                                                    .bookmodel
                                                    ?.bookdata
                                                    ?.bookproducts?[index]
                                                    .description ??
                                                'software'),
                                        sbox(h: 10),
                                        oldprice(
                                            text: cubit
                                                    .bookmodel
                                                    ?.bookdata
                                                    ?.bookproducts?[index]
                                                    .price ??
                                                'text'),
                                        sbox(h: 10),
                                        newprice(
                                            text: cubit
                                                    .bookmodel
                                                    ?.bookdata
                                                    ?.bookproducts?[index]
                                                    .priceAfterDiscount ??
                                                'sa')
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite_border)),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons
                                                .add_shopping_cart_outlined))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => sbox(h: 15),
                        itemCount: 8),
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}

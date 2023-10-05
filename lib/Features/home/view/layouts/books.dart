import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/book_model.dart';
import 'package:bookshelf/Features/home/view/screens/search.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/bookdetails.dart';

class Books extends StatelessWidget {
  BooksModel? produccts;
  Books({super.key});
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state is addtofavosuccessstate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Success',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                'Added to Favourites Successfully',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Positioned(
                      left: 20.w,
                      top: 30.h,
                      child: Icon(
                        Icons.circle,
                        size: 24.sp,
                        color: Colors.green[900],
                      )),
                  Positioned(
                      left: 0.w,
                      top: -20.h,
                      child: Icon(
                        Icons.circle,
                        size: 40.w,
                        color: Colors.green[900],
                      )),
                  Positioned(
                      left: 8.w,
                      top: -12.h,
                      child: Icon(
                        Icons.close,
                        size: 24.w,
                        color: Colors.white,
                      )),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state is addtocartsuccessstate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Success',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                'Added to Cart Successfully',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Positioned(
                      left: 20.w,
                      top: 30.h,
                      child: Icon(
                        Icons.circle,
                        size: 24.sp,
                        color: Colors.green[900],
                      )),
                  Positioned(
                      left: 0.w,
                      top: -20.h,
                      child: Icon(
                        Icons.circle,
                        size: 40.w,
                        color: Colors.green[900],
                      )),
                  Positioned(
                      left: 8.w,
                      top: -12.h,
                      child: Icon(
                        Icons.close,
                        size: 24.w,
                        color: Colors.white,
                      )),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: SizedBox(
            child: cubit.bookmodel?.data?.products?.length == null
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
                      child: Column(
                        children: [
                          sbox(h: 15),
                          InkWell(
                            onTap: () =>
                                Navigation.gopush(context, SearchScreen()),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 213, 231, 236),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            255, 205, 214, 231))),
                                width: double.infinity,
                                height: 40,
                                child: Row(
                                  children: [
                                    sbox(w: 10),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.search,
                                        )),
                                    sbox(w: 10),
                                    hometext2(
                                      text: 'search',
                                    )
                                  ],
                                )),
                          ),
                          sbox(h: 20),
                          Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () => Navigation.gopush(
                                        context,
                                        BookDetails(
                                          id: cubit.bookmodel?.data
                                              ?.products?[index],
                                        )),
                                    child: bookcard(
                                      text1: cubit.bookmodel?.data
                                              ?.products?[index].name ??
                                          ' code',
                                      text3: cubit.bookmodel?.data
                                              ?.products?[index].price ??
                                          'text',
                                      text2: cubit.bookmodel?.data
                                          ?.products?[index].category,
                                      image: cubit.bookmodel?.data
                                              ?.products?[index].image ??
                                          'text',
                                      text4:
                                          "${cubit.bookmodel?.data?.products?[index].priceAfterDiscount}",
                                      onPressed1: () {
                                        cubit.addToFav(
                                            id: cubit.bookmodel?.data
                                                    ?.products?[index].id ??
                                                0);
                                      },
                                      onPressed2: () {
                                        cubit.addtocart(
                                            id: cubit.bookmodel?.data
                                                    ?.products?[index].id ??
                                                0);
                                      },
                                      //icon: isfav?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                                    )),
                                separatorBuilder: (context, index) =>
                                    sbox(h: 15),
                                itemCount:
                                    cubit.bookmodel?.data?.products?.length ??
                                        0),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

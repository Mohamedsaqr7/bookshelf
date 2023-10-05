import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Features/home/view/screens/bookdetails.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Services/Navigation.dart';
import '../../viewmodel/homepagestate.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.searchkey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
                child: Column(
                  children: [
                    TextFormField(
                      controller: cubit.search,
                      onChanged: (String value) {
                        cubit.Searchbook(value);
                      },
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.search)),
                    ),
                    sbox(h: 15),
                    if (state is Searchloadingstate)
                      CircularProgressIndicator.adaptive(),
                    if (state is SearchSucceessstate)
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                onTap: () => Navigation.gopush(
                                    context,
                                    BookDetails(
                                      id: cubit
                                          .searcmodel?.data?.products?[index],
                                    )),
                                child: bookcard(
                                  text1: cubit.searcmodel?.data
                                          ?.products?[index].name ??
                                      ' code',
                                  text3: cubit.searcmodel?.data
                                          ?.products?[index].price ??
                                      'text',
                                  text2: cubit.searcmodel?.data
                                      ?.products?[index].category,
                                  image: cubit.searcmodel?.data
                                          ?.products?[index].image ??
                                      'text',
                                  text4:
                                      "${cubit.searcmodel?.data?.products?[index].priceAfterDiscount}",
                                  onPressed1: () {
                                    cubit.addToFav(
                                        id: cubit.searcmodel?.data
                                                ?.products?[index].id ??
                                            0);
                                  },
                                  onPressed2: () {
                                    cubit.addtocart(
                                        id: cubit.searcmodel?.data
                                                ?.products?[index].id ??
                                            0);
                                  },
                                  //icon: isfav?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                                )),
                            separatorBuilder: (context, index) => sbox(h: 15),
                            itemCount:
                                cubit.searcmodel?.data?.products?.length ?? 2),
                      )
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

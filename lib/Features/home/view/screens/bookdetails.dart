import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetails extends StatelessWidget {
  dynamic id;

  BookDetails({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomePageCubit.get(context)
      //getProductById(id),
      ,
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
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
            body: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.amberAccent,
                        child: Image.network(
                          '${id.image}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: IconButton(
                                onPressed: () {
                                  cubit.addToFav(id: id.id);
                                },
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  sbox(h: 10),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hometext1(text: '${id.name}'),
                        sbox(h: 10),
                        Row(children: [
                          hometext2(text: "${id.category}"),
                          Spacer(),
                          Column(
                            children: [
                              oldprice(text: '${id.price}'),
                              sbox(h: 5),
                              newprice(text: '${id.priceAfterDiscount}'),
                            ],
                          )
                        ]),
                        sbox(h: 10),
                        hometext1(
                          text: 'description',
                        ),
                        sbox(h: 10),
                        Container(
                            height: 190,
                            child: hometext2(text: '${id.description}')),
                        sbox(h: 5.h),
                        InkWell(
                          onTap: () => cubit.addtocart(id: id.id),
                          child: custombutton(
                              color: CustomColors.green,
                              fontcolor: Colors.white,
                              text: 'Add To Cart'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

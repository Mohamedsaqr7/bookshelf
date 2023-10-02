import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/component/bestsellercard.dart';
import 'package:bookshelf/Features/home/view/component/categorycard.dart';
import 'package:bookshelf/Features/home/view/component/newarrivalcard.dart';
import 'package:bookshelf/Features/home/view/screens/bestsellerscreen.dart';
import 'package:bookshelf/Features/home/view/screens/bookscreen.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homelayout extends StatelessWidget {
  const Homelayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 65.h),
            child: Column(
              children: [
                sbox(h: 13),
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  title: ListTile(
                      title: hometext1(text: 'Hi, username'),
                      subtitle: hometext2(text: 'What are you reading today?')),
                ),
              ],
            ),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      hometext1(text: 'Best Seller'),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigation.gopush(context, Bestsellergrid());
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  sbox(h: 20),
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Bestsellercard(
                              products: cubit.sellerdata?.products?[index]);
                        },
                        separatorBuilder: (context, index) => sbox(w: 20),
                        itemCount:
                            cubit.bestSellerModel?.sellerdata?.length ?? 5),
                  ),
                  sbox(h: 20),
                  Container(
                    height: 120,
                    child: PageView.builder(
                        onPageChanged: (index) {
                          cubit.onBoardChange(index);
                        },
                        physics: BouncingScrollPhysics(),
                        controller: cubit.boardcontroller,
                        itemBuilder: (context, index) => Container(
                              color: Colors.blue,
                              width: 250,
                              height: 20,
                            ),
                        itemCount: 2),
                  ),
                  sbox(h: 5),
                  SmoothPageIndicator(
                    controller: cubit.boardcontroller,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: CustomColors.green,
                      expansionFactor: 4.0,
                      dotWidth: 16.0,
                      dotHeight: 16.0,
                      spacing: 8.0,
                      dotColor: Colors.grey,
                    ),
                  ),
                  sbox(h: 10),
                  Row(
                    children: [
                      hometext1(text: 'categories'),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  sbox(h: 10),
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Categorycard(),
                        separatorBuilder: (context, index) => sbox(w: 5),
                        itemCount: 7),
                  ),
                  sbox(h: 10),
                  Row(
                    children: [
                      hometext1(text: 'categories'),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  sbox(h: 10),
                  // Container(
                  //   height: 250,
                  //   width: double.infinity,
                  //   child: ListView.separated(
                  //       physics: BouncingScrollPhysics(),
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) => Newarrivalcard(arrivalproducts: cubit.),
                  //       separatorBuilder: (context, index) => sbox(w: 20),
                  //       itemCount: 10),
                  // ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/View/login.dart';
import 'package:bookshelf/Features/home/view/component/bestsellercard.dart';
import 'package:bookshelf/Features/home/view/component/categorycard.dart';
import 'package:bookshelf/Features/home/view/component/drawer.dart';
import 'package:bookshelf/Features/home/view/component/newarrivalcard.dart';
import 'package:bookshelf/Features/home/view/layouts/useraccount.dart';
import 'package:bookshelf/Features/home/view/screens/categriesitems.dart';
import 'package:bookshelf/Features/home/view/screens/bookdetails.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          key: cubit.drawerkey,
          drawer: Animate(
            effects: [
              MoveEffect(),
              ShimmerEffect(duration: Duration(seconds: 1)),
            ],
            child: drawer(
              accname: hometext1(text: '${cubit.userprofilemodel?.data?.name}'),
              accimage: NetworkImage('${cubit.userprofilemodel?.data?.image}'),
              accemail: hometext2(
                  text: '${cubit.userprofilemodel?.data?.email}',
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  leading: IconButton(
                      onPressed: () =>
                          cubit.drawerkey.currentState?.openDrawer(),
                      icon: Icon(
                        Icons.menu_open,
                        color: Colors.black,
                      )),
                  title: ListTile(
                      title: hometext1(
                          text: 'Hi, ${cubit.userprofilemodel?.data?.name}'),
                      subtitle: hometext2(text: 'What are you reading today?')),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundImage: NetworkImage(
                          '${cubit.userprofilemodel?.data?.image}',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          body: SizedBox(
            child: cubit.bestSellerModel?.data?.products?.length == null ||
                    cubit.categoryModel?.data?.categories?.length == null ||
                    cubit.newarrivalmodel?.data?.products?.length == null
                ? Center(child: CircularProgressIndicator.adaptive())
                : SafeArea(
                    child: Padding(
                    padding:
                        EdgeInsets.only(left: 12.0.w, right: 12.w, top: 12.h),
                    child: SingleChildScrollView(
                      child: Animate(
                        effects: [
                          MoveEffect(
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: Duration(seconds: 2)),
                          ShimmerEffect(
                              delay: Duration(seconds: 2),
                              duration: Duration(seconds: 2)),
                        ],
                        child: Column(
                          children: [
                            Row(
                              children: [
                                hometext1(text: 'Best Seller'),
                                Spacer(),
                              ],
                            ),
                            sbox(h: 20),
                            Container(
                              height: 270,
                              width: double.infinity,
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigation.gopush(
                                            context,
                                            BookDetails(
                                              id: cubit.bestSellerModel?.data
                                                  ?.products?[index],
                                            ));
                                      },
                                      child: Bestsellercard(
                                          products: cubit.bestSellerModel?.data
                                              ?.products?[index]),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      sbox(w: 10),
                                  itemCount: cubit.bestSellerModel?.data
                                          ?.products?.length ??
                                      3),
                            ),
                            sbox(h: 5),
                            CarouselSlider(
                                items: cubit.slidermodel?.data?.sliders
                                    ?.map((e) => Image(
                                          image: NetworkImage('${e.image}'),
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  height: 150,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  initialPage: 0,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.decelerate,
                                  scrollDirection: Axis.horizontal,
                                )),
                            sbox(h: 10),
                            Row(
                              children: [
                                hometext1(text: 'Categories'),
                              ],
                            ),
                            sbox(h: 10),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          cubit.categorydetails(cubit
                                              .categoryModel
                                              ?.data
                                              ?.categories?[index]
                                              .id);
                                          Navigation.gopush(
                                              context,
                                              Categoryitems(
                                                id: cubit.categorydetailsmodel
                                                    ?.data?.products?[index].id,
                                              ));
                                        },
                                        child: Categorycard(
                                            categories: cubit.categoryModel
                                                ?.data?.categories?[index]),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      sbox(w: 5),
                                  itemCount: cubit.categoryModel?.data
                                          ?.categories?.length ??
                                      0),
                            ),
                            sbox(h: 10),
                            Row(
                              children: [
                                hometext1(
                                  text: 'New Arrival',
                                ),
                              ],
                            ),
                            sbox(h: 10),
                            Container(
                              height: 260,
                              width: double.infinity,
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Navigation.gopush(
                                              context,
                                              BookDetails(
                                                id: cubit.newarrivalmodel!.data!
                                                    .products?[index],
                                              ));
                                        },
                                        child: Newarrivalcard(
                                            arrivalproducts: cubit
                                                .newarrivalmodel!
                                                .data!
                                                .products![index]),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      sbox(w: 20),
                                  itemCount: cubit.newarrivalmodel?.data
                                          ?.products?.length ??
                                      2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
          ),
        );
      },
    );
  }
}

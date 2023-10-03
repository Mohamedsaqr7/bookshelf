import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/component/bestsellercard.dart';
import 'package:bookshelf/Features/home/view/component/categorycard.dart';
import 'package:bookshelf/Features/home/view/component/newarrivalcard.dart';
import 'package:bookshelf/Features/home/view/screens/categriesitems.dart';
import 'package:bookshelf/Features/home/view/screens/bookdetails.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.2,
            leading: Icon(
              Icons.menu_open,
              color: Colors.black,
            ),
            title: ListTile(
                title: hometext1(
                    text: 'Hi, ${cubit.userprofilemodel?.data?.name}'),
                subtitle: hometext2(text: 'What are you reading today?')),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(left: 12.0.w, right: 12.w, top: 12.h),
            child: SingleChildScrollView(
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
                                products: cubit
                                    .bestSellerModel?.data?.products?[index]),
                          );
                        },
                        separatorBuilder: (context, index) => sbox(w: 10),
                        itemCount:
                            cubit.bestSellerModel?.data?.products?.length ?? 3),
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
                    height: 40,
                    width: double.infinity,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                cubit.categorydetails(cubit.categoryModel?.data
                                    ?.categories?[index].id);
                                Navigation.gopush(
                                    context,
                                    Categoryitems(
                                      id: cubit.categorydetailsmodel?.data
                                          ?.products?[index].id,
                                    ));
                              },
                              child: Categorycard(
                                  categories: cubit
                                      .categoryModel?.data?.categories?[index]),
                            ),
                        separatorBuilder: (context, index) => sbox(w: 5),
                        itemCount:
                            cubit.categoryModel!.data!.categories!.length),
                  ),
                  sbox(h: 10),
                  Row(
                    children: [
                      hometext1(
                        text: 'New arrival',
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
                                      .newarrivalmodel!.data!.products![index]),
                            ),
                        separatorBuilder: (context, index) => sbox(w: 20),
                        itemCount:
                            cubit.newarrivalmodel?.data?.products?.length ?? 2),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

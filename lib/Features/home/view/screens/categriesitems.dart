import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/component/bestsellercard.dart';
import 'package:bookshelf/Features/home/view/screens/bookdetails.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Services/Navigation.dart';

class Categoryitems extends StatelessWidget {
  final dynamic id;

  Categoryitems({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state is addtofavosuccessstate) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to Favourites Successfully'),
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is addtocartsuccessstate) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to cart Successfully'),
            backgroundColor: Colors.amber,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);

        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              children: [
                hometext1(
                    text: '${cubit.categorydetailsmodel?.data?.name} category'),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigation.gopush(
                            context,
                            BookDetails(
                              id: cubit.categorydetailsmodel?.data
                                      ?.products?[index].id ??
                                  0,
                            )),
                        child: bookcard(
                            onPressed1: () {
                              cubit.addToFav(
                                  id: cubit.categorydetailsmodel?.data
                                          ?.products?[index].id ??
                                      0);
                            },
                            onPressed2: () {
                              cubit.addtocart(
                                  id: cubit.categorydetailsmodel?.data
                                          ?.products?[index].id ??
                                      0);
                            },
                            image:
                                "${cubit.categorydetailsmodel?.data?.products?[index].image}",
                            text1:
                                "${cubit.categorydetailsmodel?.data?.products?[index].name}",
                            text3: cubit.categorydetailsmodel?.data
                                    ?.products?[index].price ??
                                'notvalid',
                            text4:
                                "${cubit.categorydetailsmodel?.data?.products?[index].priceAfterDiscount}")),
                    separatorBuilder: (context, index) => sbox(h: 0),
                    itemCount:
                        cubit.categorydetailsmodel?.data?.products?.length ?? 0,
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}

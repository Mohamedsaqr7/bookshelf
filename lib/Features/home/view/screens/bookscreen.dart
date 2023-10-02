import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetails extends StatelessWidget {
    final int id;

   BookDetails({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:HomePageCubit.get(context)..getProductById(id),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomePageCubit.get(context);
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.amberAccent,
                ),
                sbox(h: 10),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hometext1(text:cubit.bookproducts?.name?? 'text'),
                      sbox(h: 10),
                      Row(children: [
                        hometext2(text: cubit.bookproducts?.category??'text'),
                        Spacer(),
                        Column(
                          children: [
                            oldprice(text:cubit.bookproducts?.price?? 'text'),
                            sbox(h: 5),
                            newprice(text:cubit.bookproducts?.priceAfterDiscount?? 'text'),
                          ],
                        )
                      ]),
                      sbox(h: 20),
                      hometext1(
                        text: 'description',
                      ),
                      sbox(h: 10),
                      hometext2(text: 'text'),
                      sbox(h: 30),
                      custombutton(
                          color: CustomColors.green,
                          fontcolor: Colors.white,
                          text: 'Add To Cart')
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

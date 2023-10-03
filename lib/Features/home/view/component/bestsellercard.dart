import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/bestseller_model.dart';
import 'package:bookshelf/Features/home/view/screens/bookdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Bestsellercard extends StatelessWidget {
  Products? products;
  Bestsellercard({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Image.network(
                  products?.image ?? 'h',
                  height: 130,
                  //width: double.infinity,
                ),
                Container(
                  color: Colors.grey.withOpacity(0.7),
                  width: 40.w,
                  height: 20.h,
                  child: Center(
                      child: Text(
                    '${products?.discount}%',
                  )),
                )
              ],
            ),
          ),
          sbox(h: 5),
          hometext1(text: "${products?.name}"),
          sbox(h: 5),
          hometext2(text: products?.category ?? 'asdasad'),
          sbox(h: 5),
          oldprice(text: products?.price ?? 'texkkt'),
          sbox(h: 5),
          newprice(text: "${products?.priceAfterDiscount}")
        ],
      ),
    );
  }
}

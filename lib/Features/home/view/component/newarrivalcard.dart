import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/newarrival_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Services/Navigation.dart';
import '../screens/bookdetails.dart';

class Newarrivalcard extends StatelessWidget {
  Products arrivalproducts;
  Newarrivalcard({required this.arrivalproducts, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Image.network(
                  '${arrivalproducts.image}',
                  height: 130,
                ),
                Container(
                  color: Colors.grey.withOpacity(0.7),
                  width: 40.w,
                  height: 20.h,
                  child: Center(
                      child: Text(
                    '${arrivalproducts.discount}%',
                  )),
                )
              ],
            ),
          ),
          sbox(h: 5),
          hometext1(text: "${arrivalproducts.name}"),
          sbox(h: 5),
          hometext2(text: arrivalproducts.category ?? 'asdasad'),
          sbox(h: 5),
          oldprice(text: arrivalproducts.price ?? 'texkkt'),
          sbox(h: 5),
          newprice(text: "${arrivalproducts.priceAfterDiscount}")
        ],
      ),
    );
  }
}

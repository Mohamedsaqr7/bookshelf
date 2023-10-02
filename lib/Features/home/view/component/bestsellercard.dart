import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/bestsellermodel.dart';
import 'package:bookshelf/Features/home/view/screens/bookscreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Bestsellercard extends StatelessWidget {
  Products? products;
  Bestsellercard({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.gopush(context, BookDetails(id: products?.id ?? 0));
      },
      child: Container(
        width: 90,
        height: 120,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 120,
              color: Colors.green,
            ),
            sbox(h: 5),
            hometext1(text: "${products?.name}"),
            sbox(h: 5),
            hometext2(text: products?.description ?? 'asdasad'),
            sbox(h: 5),
            oldprice(text: products?.price ?? 'texkkt'),
            sbox(h: 5),
            newprice(text: "${products?.priceAfterDiscount}")
          ],
        ),
      ),
    );
  }
}

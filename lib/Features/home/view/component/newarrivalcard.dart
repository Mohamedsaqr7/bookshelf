import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Services/Navigation.dart';
import '../../model/newarrival.dart';
import '../screens/bookscreen.dart';

class Newarrivalcard extends StatelessWidget {
  Arrivalproducts arrivalproducts;
   Newarrivalcard({required this.arrivalproducts, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.gopush(context, BookDetails(id: arrivalproducts?.id ?? 0));
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
            hometext1(text: 'texssssssssssssst'),
            sbox(h: 5),
            hometext2(text: 'asdasad'),
            sbox(h: 5),
            oldprice(text: 'texkkt'),
            sbox(h: 5),
            newprice(text: 'text')
          ],
        ),
      ),
    );
  }
}

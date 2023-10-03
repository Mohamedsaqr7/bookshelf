import 'package:bookshelf/Core/textWidgets.dart';
import 'package:flutter/material.dart';

import '../../model/category_model.dart';

class Categorycard extends StatelessWidget {
  Categories? categories;
  Categorycard({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      child: Center(child: hometext1(text: categories?.name ?? 'text',max: 1)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
    );
  }
}

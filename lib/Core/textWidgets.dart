import 'package:bookshelf/Core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget authtext({
  required String text,
  double? size,
  FontWeight? weight,
  Color? colorr,
}) =>
    Text(
      text,
      style: TextStyle(color: colorr, fontSize: size?.sp, fontWeight: weight),
    );
hometext1({required String text, Color? color, int? max}) => Text(
      maxLines: max ?? 2,
      text,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color ?? Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold),
    );
hometext2({
  required String text,
}) =>
    Text(
      text,
      maxLines: 11,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.normal),
    );
oldprice({
  required String text,
}) =>
    Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: const Color.fromARGB(255, 231, 25, 10).withOpacity(0.6),
          fontSize: 15.sp,
          fontWeight: FontWeight.normal),
    );
newprice({
  required String text,
}) =>
    Text(
      text,
      style: TextStyle(
          color: CustomColors.green,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold),
    );

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
hometext1({
  required String text,
}) =>
    Text(
      maxLines: 2,
      text,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold),
    );
hometext2({
  required String text,
}) =>
    Text(
      text,
      style: TextStyle(
          color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.normal),
    );
oldprice({
  required String text,
}) =>
    Text(
      text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.6),
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
          fontWeight: FontWeight.normal),
    );

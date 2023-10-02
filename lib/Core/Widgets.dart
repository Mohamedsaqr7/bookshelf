import 'package:bookshelf/Core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sbox({double? w, double? h}) => SizedBox(
      width: w?.w,
      height: h?.h,
    );
Widget custombutton({
  required Color color,
  required Color fontcolor,
  required String text,
  double? w,
  double? h,
  double? size,
}) =>
    Container(
      width: w ?? 350.w,
      height: h ?? 50.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50.r)),
      child: Center(
        child: Text(
          '$text',
          style: TextStyle(fontSize: size ?? 20.sp, color: fontcolor),
        ),
      ),
    );
Widget customTextfield({
  required TextEditingController controller,
  String? errormessage,
  required String label,
  required TextInputType type,
  required IconData prefix,
  IconButton? suffix,
  FormFieldValidator? onchanged,
  required FormFieldValidator validate,
  bool ispassword = false,
}) =>
    TextFormField(
      onChanged: onchanged,
      validator: validate,
      showCursor: true,
      keyboardType: type,
      obscureText: ispassword,
      cursorColor: CustomColors.primarycolor,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(prefix),
          prefixIconColor: CustomColors.primarycolor,
          label:
              Text(label, style: TextStyle(color: CustomColors.primarycolor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Color.fromARGB(255, 226, 16, 16))),
          suffixIcon: suffix,
          suffixIconColor: CustomColors.primarycolor),
      controller: controller,
    );

import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
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
  IconData? prefix,
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

bookcard({
  required String text1,
  String? text2,
  required String text3,
  required String image,
  required dynamic text4,
  Icon? icon,
  final VoidCallback? onPressed1,
  final VoidCallback? onPressed2,
}) =>
    SizedBox(
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromARGB(255, 205, 214, 231),
          ),
        ),
        color: Color.fromARGB(255, 213, 231, 236),
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 130,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              sbox(w: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 150, child: hometext1(text: text1 ?? ' code')),
                  sbox(h: 10),
                  hometext2(text: text2 ?? 'software'),
                  Spacer(),
                  oldprice(text: "$text3" ?? 'text' 'LE'),
                  sbox(h: 10),
                  newprice(text: "$text4" ?? 'sa')
                ],
              ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                      onPressed: onPressed1,
                      icon: icon ??
                          Icon(
                            Icons.favorite_border,
                          )),
                  Spacer(),
                  IconButton(
                      onPressed: onPressed2,
                      icon: Icon(Icons.add_shopping_cart_outlined))
                ],
              )
            ],
          ),
        ),
      ),
    );

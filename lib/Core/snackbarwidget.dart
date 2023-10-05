import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customSnackbar({
  required String status,
  required String message,
}) =>
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                SizedBox(
                  width: 40.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        message,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
            height: 70.h,
            decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.circular(20)),
          ),
          Positioned(
              left: 20.w,
              top: 30.h,
              child: Icon(
                Icons.circle,
                size: 24.sp,
                color: Colors.green[900],
              )),
          Positioned(
              left: 0.w,
              top: -20.h,
              child: Icon(
                Icons.circle,
                size: 40.w,
                color: Colors.green[900],
              )),
          Positioned(
              left: 8.w,
              top: -12.h,
              child: Icon(
                Icons.close,
                size: 24.w,
                color: Colors.white,
              )),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );

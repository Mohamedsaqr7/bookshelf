import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/View/login.dart';
import 'package:bookshelf/Features/Authentications/View/otp.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
import 'package:bookshelf/Features/home/view/layouts/useraccount.dart';
import 'package:bookshelf/Features/home/view/screens/homepage.dart';
import 'package:bookshelf/x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ViewModel/authstate.dart';

class Register extends StatelessWidget {
  Register({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserRegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
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
                                'Error',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Positioned(
                      left: 20.w,
                      top: 30.h,
                      child: Icon(
                        Icons.circle,
                        size: 24.sp,
                        color: Colors.red[900],
                      )),
                  Positioned(
                      left: 0.w,
                      top: -20.h,
                      child: Icon(
                        Icons.circle,
                        size: 40.w,
                        color: Colors.red[900],
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
            ),
          );
        }

        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.regkey,
            child: SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sbox(h: 80),
                      authtext(
                          text: 'Join Us!',
                          colorr: CustomColors.primarycolor,
                          weight: FontWeight.bold,
                          size: 24.sp),
                      sbox(h: 30),
                      Row(
                        children: [
                          authtext(
                              text: 'already have an account?',
                              colorr: Colors.grey),
                          sbox(w: 15),
                          InkWell(
                            onTap: () {
                              Navigation.gopush(context, Login());
                            },
                            child: authtext(
                                text: 'Login',
                                colorr: CustomColors.primarycolor),
                          )
                        ],
                      ),
                      sbox(h: 15),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: CustomColors.primarycolor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                customTextfield(
                                  label: 'Name',
                                  prefix: Icons.person,
                                  controller: cubit.name,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.trim().isEmpty)
                                      return 'Enter Your Name';
                                    return null;
                                  },
                                ),
                                sbox(h: 15),
                                customTextfield(
                                  label: 'Email',
                                  prefix: Icons.email,
                                  controller: cubit.email,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.trim()!.isEmpty)
                                      return 'Enter Your email';

                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please Enter Valid E-Mail';
                                    }
                                    return null;
                                  },
                                ),
                                sbox(h: 15),
                                customTextfield(
                                  label: 'password',
                                  prefix: Icons.lock,
                                  controller: cubit.password,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.trim()!.isEmpty)
                                      return 'Enter Your password';
                                    return null;
                                  },
                                ),
                                sbox(h: 15),
                                customTextfield(
                                  label: 'Confirm password',
                                  prefix: Icons.lock,
                                  controller: cubit.confirmpassword,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.trim()!.isEmpty)
                                      return 'The Field Can\'t Be Empty';
                                    else if (cubit.password.text !=
                                        cubit.confirmpassword.text)
                                      return 'not the same password';
                                    else if (cubit.password.text ==
                                        cubit.confirmpassword.text) return null;

                                    return null;
                                  },
                                ),
                                sbox(h: 15),
                                InkWell(
                                  onTap: () {
                                    if (cubit.regkey.currentState!.validate()) {
                                      cubit.register();
                                      Navigation.gopush(context, OTP());
                                    }
                                  },
                                  child: custombutton(
                                    color: CustomColors.primarycolor,
                                    fontcolor: Colors.white,
                                    text: 'Register',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}

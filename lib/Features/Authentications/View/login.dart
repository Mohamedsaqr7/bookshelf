import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/snackbarwidget.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/View/Register.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authstate.dart';
import 'package:bookshelf/Features/home/view/layouts/books.dart';
import 'package:bookshelf/Features/home/view/layouts/cart.dart';
import 'package:bookshelf/Features/home/view/layouts/fav.dart';
import 'package:bookshelf/Features/home/view/layouts/homelayout.dart';
import 'package:bookshelf/Features/home/view/layouts/useraccount.dart';
import 'package:bookshelf/Features/home/view/screens/homepage.dart';
import 'package:bookshelf/x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is forgetpasssuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Check your mail'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is UserlogsuccessState) {
          Navigation.gopushreplace(context, HomePage());
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
                                'Success',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                'Logged in Successfully',
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
            ),
          );
        } else if (state is UserlogErrorState) {
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
            key: cubit.logkey,
            child: SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sbox(h: 50),
                      authtext(
                          text: 'Login Now!',
                          colorr: CustomColors.primarycolor,
                          weight: FontWeight.bold,
                          size: 24.sp),
                      sbox(h: 30),
                      Row(
                        children: [
                          authtext(
                              text: 'Don\'t have an account?',
                              colorr: Color.fromARGB(255, 102, 99, 99)),
                          sbox(w: 15),
                          InkWell(
                            onTap: () => Navigation.gopush(context, Register()),
                            child: authtext(
                                text: 'Register Now!',
                                colorr: CustomColors.primarycolor),
                          )
                        ],
                      ),
                      sbox(h: 15),
                      Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: CustomColors.primarycolor),
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                customTextfield(
                                  controller: cubit.logemail,
                                  label: 'email',
                                  type: TextInputType.emailAddress,
                                  prefix: Icons.email,
                                  validate: (value) {
                                    if (value!.trim().isEmpty)
                                      return 'enter email';
                                    return null;
                                  },
                                ),
                                sbox(h: 15),
                                customTextfield(
                                  controller: cubit.logpassword,
                                  label: 'password',
                                  type: TextInputType.emailAddress,
                                  prefix: Icons.lock,
                                  validate: (value) {
                                    if (value!.trim().isEmpty)
                                      return 'enter password';
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: cubit.keepMecheckbox,
                                        onChanged: (value) =>
                                            cubit.changecheck()),
                                    authtext(
                                        text: 'Keep me Logged in',
                                        colorr: const Color.fromARGB(
                                            255, 102, 99, 99)),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        cubit.sendforgetpass();
                                      },
                                      child: authtext(
                                          text: 'Forgot Password?',
                                          colorr: CustomColors.primarycolor),
                                    ),
                                  ],
                                ),
                                sbox(h: 15),
                                InkWell(
                                  onTap: () {
                                    if (cubit.logkey.currentState!.validate()) {
                                      cubit.login();
                                    }
                                  },
                                  child: custombutton(
                                    color: CustomColors.primarycolor,
                                    fontcolor: Colors.white,
                                    text: 'Login',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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

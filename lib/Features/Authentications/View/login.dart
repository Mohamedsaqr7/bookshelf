import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authstate.dart';
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
        if (state is UserlogsuccessState) {
          Navigation.gopushreplace(context, HomePage());
          const snackBar = SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is UserlogErrorState) {
          const snackBar = SnackBar(
            content: Text('Password or Email is not correct'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                              colorr: Colors.grey),
                          sbox(w: 15),
                          authtext(
                              text: 'Register Now!',
                              colorr: CustomColors.primarycolor)
                        ],
                      ),
                      sbox(h: 15),
                      Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: CustomColors.primarycolor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            customTextfield(
                              controller: cubit.logemail,
                              label: 'email',
                              type: TextInputType.emailAddress,
                              prefix: Icons.email,
                              validate: (value) {
                                if (value!.trim().isEmpty) return 'enter email';
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

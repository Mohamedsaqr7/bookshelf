import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
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
        if (state is UserRegistersuccessState) {
          Navigation.gopushreplace(context, home());
          const snackBar = SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is UserRegisterErrorState) {
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
                          authtext(
                              text: 'Login', colorr: CustomColors.primarycolor)
                        ],
                      ),
                      sbox(h: 15),
                      Container(
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
                          child: Column(
                            children: [
                              customTextfield(
                                label: 'Name',
                                prefix: Icons.person,
                                controller: cubit.name,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.trim().isEmpty)
                                    return 'The Field Can\'t Be Empty';
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
                                    return 'The Field Can\'t Be Empty';
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
                                    return 'The Field Can\'t Be Empty';
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
                                  if (cubit.regkey.currentState!.validate()|| cubit.password.text==cubit.confirmpassword.text) {
                                    cubit.register();
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

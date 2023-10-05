import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authstate.dart';
import 'package:bookshelf/Features/home/view/screens/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTP extends StatelessWidget {
  const OTP({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);

        return Scaffold(
          backgroundColor: CustomColors.primarycolor,
          body: SafeArea(
              child: Center(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back)),
                  sbox(w: 20),
                  sbox(h: 50.h),
                  hometext1(text: 'Verify Your Email', size: 35),
                  sbox(h: 20.h),
                  authtext(
                      text: 'Code sent to : ${cubit.email.text}', size: 20),
                  sbox(h: 20.h),
                  PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    appContext: context,
                    autoFocus: true,
                    pinTheme: PinTheme(
                      activeColor: CustomColors.primarycolor,
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60.h,
                      fieldWidth: 50.w,
                      selectedFillColor: Colors.white,
                      inactiveColor: const Color.fromARGB(255, 192, 113, 113),
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.green[700],
                    ),
                    length: 6,
                    onChanged: (value) {
                      print(value);
                    },
                    onCompleted: (v) {
                      cubit.verifyemail();
                    },
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    animationType: AnimationType.slide,
                    cursorColor: Colors.black,
                    animationDuration: const Duration(seconds: 1),
                    controller: cubit.pin,
                  ),
                  Spacer(),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: TextButton(
                      onPressed: () {
                        Countdown(
                          seconds: 90,
                          interval: const Duration(seconds: 1),
                          build: (context, double time) => Text(
                            (time < 60)
                                ? "0 : ${time.toInt()}"
                                : "${time ~/ 60} : ${(((time / 60) - (time ~/ 60)) * 60).toInt()}",
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          hometext1(
                            text: "Resend Code",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Countdown(
                            seconds: 70,
                            onFinished: () {
                              cubit.resendverifyemail();
                            },
                            interval: const Duration(seconds: 1),
                            build: (context, double time) => Text(
                              (time < 60)
                                  ? "0 : ${time.toInt()}"
                                  : "${time ~/ 60} : ${(((time / 60) - (time ~/ 60)) * 60).toInt()}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

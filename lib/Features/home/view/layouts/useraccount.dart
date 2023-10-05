import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Features/home/view/layouts/homelayout.dart';
import 'package:bookshelf/Features/home/view/screens/homepage.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class useraccount extends StatelessWidget {
  const useraccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomePageCubit.get(context)..initcontroller(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state is updateaccountSucceessstate) {
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
                                  'Profile Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
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
          }
        },
        builder: (context, state) {
          var cubit = HomePageCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Form(
              key: cubit.userkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0.w, right: 12.w),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          sbox(h: 30),
                          CircleAvatar(
                              radius: 80.r,
                              backgroundImage: NetworkImage(
                                "${cubit.userprofilemodel?.data?.image}",
                              )),
                          sbox(h: 20),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 205, 214, 231)),
                            ),
                            color: Color.fromARGB(255, 220, 228, 243)
                                .withOpacity(0.9),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                children: [
                                  sbox(h: 20),
                                  customTextfield(
                                    label: 'Name',
                                    prefix: Icons.person,
                                    controller: cubit.username,
                                    type: TextInputType.name,
                                    validate: (value) {
                                      if (value!.trim().isEmpty)
                                        return 'Enter Your Name';
                                      return null;
                                    },
                                  ),
                                  sbox(h: 15),
                                  customTextfield(
                                    label: 'phone',
                                    prefix: Icons.phone,
                                    controller: cubit.userphone,
                                    type: TextInputType.text,
                                    validate: (value) {},
                                  ),
                                  sbox(h: 15),
                                  customTextfield(
                                    label: 'city',
                                    prefix: Icons.location_city,
                                    controller: cubit.usercity,
                                    type: TextInputType.text,
                                    validate: (value) {},
                                  ),
                                  sbox(h: 15),
                                  customTextfield(
                                    label: 'address',
                                    prefix: Icons.location_on,
                                    controller: cubit.useraddress,
                                    type: TextInputType.text,
                                    validate: (value) {},
                                  ),
                                  sbox(h: 15),
                                ],
                              ),
                            ),
                          ),
                          sbox(h: 20),
                          InkWell(
                            onTap: () {
                              if (cubit.userkey.currentState!.validate()) {
                                cubit.updateProfile();
                              }
                            },
                            child: custombutton(
                              color: CustomColors.primarycolor,
                              fontcolor: Colors.white,
                              text: 'Update',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}

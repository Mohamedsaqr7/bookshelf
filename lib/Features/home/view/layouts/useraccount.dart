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
            SnackBar snackBar = SnackBar(
              content: Text('update Successfully'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigation.gopush(context, HomePage());
          }
          // TODO: implement listener
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
                          InkWell(
                            onTap: () {
                              if (cubit.userkey.currentState!.validate())
                                cubit.updateProfile();
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

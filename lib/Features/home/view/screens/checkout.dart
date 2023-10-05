import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/layouts/homelayout.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is placeorderSucceessstate) {
          SnackBar snackBar = SnackBar(
            content: const Text('Order placed successfully'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigation.gopushreplace(context, Homelayout());
        }
        if (state is placeorderErrorstate) {
          SnackBar snackBar = SnackBar(
            content: const Text('Order placed failed'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.checkoutuserkey,
                child: Column(
                  children: [
                    customTextfield(
                      controller: cubit.checkoutusername,
                      label: 'name',
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.trim().isEmpty) return 'enter name';
                        return null;
                      },
                    ),
                    sbox(h: 20),
                    customTextfield(
                      controller: cubit.checkoutuseremail,
                      label: 'Email',
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.trim().isEmpty) return 'enter email';
                        return null;
                      },
                    ),
                    sbox(h: 20),
                    customTextfield(
                      controller: cubit.checkoutuserphone,
                      label: 'phone',
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.trim().isEmpty) return 'enter phone';
                        return null;
                      },
                    ),
                    sbox(h: 20),
                    customTextfield(
                      controller: cubit.checkoutuseraddress,
                      label: 'address',
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.trim().isEmpty) return 'enter address';
                        return null;
                      },
                    ),
                    sbox(h: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: ExpansionTile(
                        title: hometext1(text: 'City'),
                        children: [
                          Container(
                            height: 90,
                            child: ListView.separated(
                                itemBuilder: (context, index) => RadioListTile(
                                    title: hometext1(
                                        text:
                                            "${cubit.citymodel?.data?[index].governorateNameEn}",
                                        color: Colors.black),
                                    value: cubit.citymodel?.data?[index].id,
                                    groupValue: cubit.cityindex,
                                    onChanged: (value) => cubit.filter(value)),
                                separatorBuilder: (context, index) =>
                                    sbox(h: 5),
                                itemCount: cubit.citymodel?.data?.length ?? 4),
                          )
                        ],
                      ),
                    ),
                    sbox(h: 10),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    sbox(h: 10),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                              title: SizedBox(
                                  width: 5.w,
                                  child: hometext1(
                                      max: 2,
                                      text: cubit
                                              .cartmodel
                                              ?.data
                                              ?.cartItems?[index]
                                              .itemProductName ??
                                          '')),
                              subtitle: hometext2(
                                  text:
                                      "quantity: ${cubit.cartmodel?.data?.cartItems?[index].itemQuantity}"),
                              trailing: newprice(
                                  text:
                                      '${cubit.cartmodel?.data?.cartItems?[index].itemTotal}'),
                            ),
                        separatorBuilder: (context, index) => sbox(h: 10),
                        itemCount:
                            cubit.cartmodel?.data?.cartItems?.length ?? 2),
                    sbox(h: 20),
                    InkWell(
                      onTap: () {
                        if (cubit.checkoutuserkey.currentState!.validate())
                          return cubit.placeorder();
                      },
                      child: custombutton(
                          color: CustomColors.primarycolor,
                          fontcolor: Colors.white,
                          text: 'Place Order'),
                    )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}

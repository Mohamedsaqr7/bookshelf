import 'package:bookshelf/Core/Services/Navigation.dart';
import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/screens/checkout.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: SizedBox(
            child: cubit.cartmodel?.data?.cartItems?.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 200.sp,
                          color: Colors.grey,
                        ),
                        hometext1(text: 'No Oorders yet', size: 35.sp)
                      ],
                    ),
                  )
                : SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                      child: Column(
                        children: [
                          Container(
                            height: 600,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 150,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 205, 214, 231),
                                        ),
                                      ),
                                      color: Color.fromARGB(255, 213, 231, 236),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: double.infinity,
                                              child: Image.network(
                                                  '${cubit.cartmodel!.data!.cartItems![index].itemProductImage}'),
                                            ),
                                            sbox(w: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: hometext1(
                                                      max: 2,
                                                      text:
                                                          '${cubit.cartmodel!.data!.cartItems![index].itemProductName}'),
                                                ),
                                                sbox(h: 30),
                                                SizedBox(
                                                  width: 140,
                                                  height: 45,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: const BorderSide(
                                                        color:
                                                            Color(0xffE2E2E2),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              int? currentquantity = cubit
                                                                  .cartmodel!
                                                                  .data!
                                                                  .cartItems![
                                                                      index]
                                                                  .itemQuantity;
                                                              cubit.updatecart(
                                                                  id: cubit
                                                                          .cartmodel!
                                                                          .data!
                                                                          .cartItems![
                                                                              index]
                                                                          .itemId ??
                                                                      0,
                                                                  quantity:
                                                                      currentquantity! +
                                                                          1);
                                                            },
                                                            icon: Icon(
                                                                Icons.add)),
                                                        Spacer(),
                                                        Text(
                                                            '${cubit.cartmodel!.data!.cartItems![index].itemQuantity}'),
                                                        Spacer(),
                                                        IconButton(
                                                            onPressed: () {
                                                              int? currentquantity = cubit
                                                                  .cartmodel!
                                                                  .data!
                                                                  .cartItems![
                                                                      index]
                                                                  .itemQuantity;
                                                              if (currentquantity! >
                                                                  1) {
                                                                cubit.updatecart(
                                                                    id: cubit
                                                                            .cartmodel!
                                                                            .data!
                                                                            .cartItems![
                                                                                index]
                                                                            .itemId ??
                                                                        0,
                                                                    quantity:
                                                                        currentquantity -
                                                                            1);
                                                              }
                                                            },
                                                            icon: Icon(Icons
                                                                .remove_outlined))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cubit.removecart(
                                                          id: cubit
                                                                  .cartmodel
                                                                  ?.data
                                                                  ?.cartItems?[
                                                                      index]
                                                                  .itemId ??
                                                              0);
                                                    },
                                                    icon: Icon(Icons
                                                        .remove_shopping_cart_outlined)),
                                                oldprice(
                                                    text:
                                                        '${cubit.cartmodel!.data!.cartItems![index].itemProductPrice}'),
                                                newprice(
                                                    text:
                                                        '${cubit.cartmodel!.data!.cartItems![index].itemProductPriceAfterDiscount}')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    sbox(h: 5),
                                itemCount:
                                    cubit.cartmodel?.data?.cartItems?.length ??
                                        0),
                          ),
                          SizedBox(
                            width: 350,
                            height: 70,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 205, 214, 231),
                                ),
                              ),
                              color: CustomColors.primarycolor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  hometext1(
                                      color: Colors.white,
                                      text: 'total price is : '
                                          ' ${cubit.cartmodel?.data?.total ?? 0.0}'),
                                  InkWell(
                                    onTap: () {
                                      Navigation.gopush(context, CheckOut());
                                    },
                                    child: custombutton(
                                      w: 130,
                                      h: 40,
                                      size: 18,
                                      color: Colors.white,
                                      fontcolor: CustomColors.primarycolor,
                                      text: 'checkout',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

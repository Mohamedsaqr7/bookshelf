import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/model/book_model.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Books extends StatelessWidget {
  BooksModel? produccts;
  Books({super.key});
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state is addtofavosuccessstate) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to Favourites Successfully'),
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is addtocartsuccessstate) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to cart Successfully'),
            backgroundColor: Colors.amber,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.searchkey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
                child: Column(
                  children: [
                    TextFormField(
                      controller: cubit.search,
                      onChanged: (String value) {
                        cubit.Searchbook(value);
                      },
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.search)),
                    ),
                    sbox(h: 15),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => bookcard(
                                text1: cubit.bookmodel?.data?.products?[index]
                                        .name ??
                                    ' code',
                                text3: cubit.bookmodel?.data?.products?[index]
                                        .price ??
                                    'text',
                                text2: cubit
                                    .bookmodel?.data?.products?[index].category,
                                image: cubit.bookmodel?.data?.products?[index]
                                        .image ??
                                    'text',
                                text4:
                                    "${cubit.bookmodel?.data?.products?[index].priceAfterDiscount}",
                                onPressed1: () {
                                  cubit.addToFav(
                                      id: cubit.bookmodel?.data
                                              ?.products?[index].id ??
                                          0);
                                },
                                onPressed2: () {
                                  cubit.addtocart(
                                      id: cubit.bookmodel?.data
                                              ?.products?[index].id ??
                                          0);
                                },
                                //icon: isfav?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                              ),
                          separatorBuilder: (context, index) => sbox(h: 15),
                          itemCount:
                              cubit.bookmodel?.data?.products?.length ?? 2),
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

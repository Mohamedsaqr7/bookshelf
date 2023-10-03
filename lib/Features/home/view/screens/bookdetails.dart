import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetails extends StatelessWidget {
  dynamic id;

  BookDetails({this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomePageCubit.get(context)
      //getProductById(id),
      ,
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is addtofavosuccessstate) {
            SnackBar snackBar = SnackBar(
              content: Text('Added to Favourites Successfully'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = HomePageCubit.get(context);
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.amberAccent,
                      child: Image.network(
                        '${id.image}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              cubit.addToFav(id: id.id);
                            },
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                sbox(h: 10),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hometext1(text: '${id.name}'),
                      sbox(h: 10),
                      Row(children: [
                        hometext2(text: "${id.category}"),
                        Spacer(),
                        Column(
                          children: [
                            oldprice(text: '${id.price}'),
                            sbox(h: 5),
                            newprice(text: '${id.priceAfterDiscount}'),
                          ],
                        )
                      ]),
                      sbox(h: 20),
                      hometext1(
                        text: 'description',
                      ),
                      sbox(h: 10),
                      hometext2(text: '${id.description}'),
                      sbox(h: 30),
                      custombutton(
                          color: CustomColors.green,
                          fontcolor: Colors.white,
                          text: 'Add To Cart')
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

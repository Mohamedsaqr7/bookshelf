import 'package:bookshelf/Core/Services/Network/Diohelper.dart';
import 'package:bookshelf/Core/Services/Network/Endpoint.dart';
import 'package:bookshelf/Features/home/model/bestsellermodel.dart';
import 'package:bookshelf/Features/home/model/bookmodel.dart';
import 'package:bookshelf/Features/home/model/categorymodel.dart';
import 'package:bookshelf/Features/home/view/layouts/books.dart';
import 'package:bookshelf/Features/home/view/layouts/cart.dart';
import 'package:bookshelf/Features/home/view/layouts/fav.dart';
import 'package:bookshelf/Features/home/view/layouts/useraccount.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/Services/local/Secure_storagee.dart';
import '../view/layouts/homelayout.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(homePageInitState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.book,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.search,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.access_time,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.person_2_outlined,
      size: 30.sp,
      color: Colors.white,
    ),
  ];
  int currentindex = 0;

  void changecurrentindex(index) {
    currentindex = index;
    emit(changeindex());
  }

  var boardcontroller = PageController();

  List<Widget> layouts = [
    Homelayout(),
    Books(),
    Favourite(),
    Cart(),
    useraccount()
  ];
  void onBoardChange(index) {
    if (index == 3) {
      isLast = true;
    } else {
      isLast = false;
    }
  }

  var searchkey = GlobalKey<FormState>();
  var search = TextEditingController();

  bool isLast = false;
  Sellerdata? sellerdata;
  BestSellerModel? bestSellerModel;
  void bestseller() async {
    emit(bestsellerloadingstate());
    await DioHelper.get(
            endpoint: Endpoint.bestseller,
            token: await SecureStorage().storage.read(key: 'token'))
        .then(
      (value) {
        bestSellerModel = BestSellerModel.fromJson(value.data);
        emit(bestsellersuccessstate());
      },
    ).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(bestsellererrorstate());
    });
  }

  CategoryModel? categoryModel;
  getcategory() {
    emit(categoryloadingstate());
    DioHelper.get(endpoint: Endpoint.categories).then(
      (value) {
        categoryModel = CategoryModel.fromJson(value.data);
        emit(categorysuccessstate());
      },
    ).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(categoryerrorstate());
    });
  }

  Bookmodel? bookmodel;
  getbook() async {
    emit(bookloadingstate());
    await DioHelper.get(endpoint: Endpoint.products).then(
      (value) {
        bookmodel = Bookmodel.fromJson(value.data);
        emit(booksuccessstate());
      },
    ).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(bookerrorstate());
    });
  }

  Bookproducts? bookproducts;
  Future<void> getProductById(int id) async {
    emit(GetProductByIDLoadingState());
    DioHelper.get(endpoint: "${Endpoint.products}/$id").then((value) {
      bookproducts = Bookproducts.fromJson(value.data["data"]);
      emit(GetProductByIDSuccessState());
    }).catchError((onError) {
      emit(GetProductByIDErrorState());
      print(onError);
      throw onError;
    });
  }
}

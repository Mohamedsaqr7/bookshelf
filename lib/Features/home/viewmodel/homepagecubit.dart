import 'package:bookshelf/Features/home/model/City_model.dart';
import 'package:bookshelf/Features/home/model/add_tocart_model.dart';
import 'package:bookshelf/Features/home/model/add_tofavo_model.dart';
import 'package:bookshelf/Features/home/model/bestseller_model.dart';
import 'package:bookshelf/Features/home/model/cart_model.dart';
import 'package:bookshelf/Features/home/model/favo_model.dart';
import 'package:bookshelf/Features/home/model/newarrival_model.dart';
import 'package:bookshelf/Features/home/model/placeorder_model.dart';
import 'package:bookshelf/Features/home/model/remove_cart.dart';
import 'package:bookshelf/Features/home/model/slider_model.dart';
import 'package:bookshelf/Features/home/view/layouts/books.dart';
import 'package:bookshelf/Features/home/view/layouts/cart.dart';
import 'package:bookshelf/Features/home/view/layouts/fav.dart';
import 'package:bookshelf/Features/home/view/layouts/homelayout.dart';
import 'package:bookshelf/Features/home/view/layouts/useraccount.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagestate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/Services/Network/Diohelper.dart';
import '../../../Core/Services/Network/Endpoint.dart';
import '../../../Core/Services/local/Secure_storagee.dart';
import '../../Authentications/model/userprofile_model.dart';
import '../model/book_model.dart';
import '../model/category_model.dart';
import '../model/categorydetails.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(homePageInitState());

  static HomePageCubit get(context) => BlocProvider.of(context);
  var username = TextEditingController();
  var useremail = TextEditingController();
  var userphone = TextEditingController();
  var usercity = TextEditingController();
  var useraddress = TextEditingController();
  var userkey = GlobalKey<FormState>();

  var checkoutusername = TextEditingController();
  var checkoutuseremail = TextEditingController();
  var checkoutuserphone = TextEditingController();
  var checkoutusercity = TextEditingController();
  var checkoutuseraddress = TextEditingController();
  var checkoutuserkey = GlobalKey<FormState>();
  initcontroller() {
    username.text = userprofilemodel?.data?.name ?? 'username';
    useremail.text = userprofilemodel?.data?.email ?? 'useremail';
    userphone.text = '${userprofilemodel?.data?.phone ?? 'userphone'}';
    usercity.text = userprofilemodel?.data?.city ?? 'usercity';
    useraddress.text = userprofilemodel?.data?.address ?? 'useraddress';
    emit(InituserState());
  }

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
      Icons.favorite,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.shopping_cart,
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

  UserProfileModel? userprofilemodel;
  getuseraccount() async {
    emit(userloadingstate());
    await DioHelper.getData(
      url: Endpoint.profile,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print(
        await SecureStorage().storage.read(key: 'token'),
      );
      userprofilemodel = UserProfileModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(usersuccessstate());
      }
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(usererrorstate());
    });
  }

  var searchkey = GlobalKey<FormState>();
  var search = TextEditingController();

  bool isLast = false;

  BestSellerModel? bestSellerModel;

  void bestseller() async {
    emit(bestsellerloadingstate());
    await DioHelper.getData(
            url: Endpoint.bestseller,
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

  CategoriesModel? categoryModel;
  getcategory() async {
    emit(categoryloadingstate());
    await DioHelper.getData(
      url: Endpoint.categories,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then(
      (value) {
        categoryModel = CategoriesModel.fromJson(value.data);
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

  NewArrivalModel? newarrivalmodel;

  getnewarrival() async {
    emit(newarrivalloadingstate());
    await DioHelper.getData(
      url: Endpoint.newarrival,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      newarrivalmodel = NewArrivalModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(newarrivalsuccessstate());
      }

      print(
          ' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(newarrivalerrorstate());
    });
  }

  BooksModel? bookmodel;
  getbook() async {
    emit(bookloadingstate());
    await DioHelper.getData(
      url: Endpoint.products,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then(
      (value) {
        bookmodel = BooksModel.fromJson(value.data);
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

  CategoryDetailsModel? categorydetailsmodel;

  categorydetails(id) async {
    emit(getcategoryloadingstate());
    await DioHelper.getData(
      url: '${Endpoint.categories}/$id',
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      categorydetailsmodel = CategoryDetailsModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(getcategorysuccessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(getcategoryerrorstate());
    });
  }

  BooksModel? searchbook;
  void Searchbook(text) async {
    emit(SearchDoctorsloadingstate());
    await DioHelper.getData(
            url: Endpoint.search,
            query: {'name': '$text'},
            token: await SecureStorage().storage.read(key: 'token'))
        .then((value) {
      searchbook = BooksModel.fromJson(value.data);
      emit(SearchDoctorsSucceessstate());
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(SearchDoctorsErrorstate());
    });
  }

  SliderModel? slidermodel;
  slider() async {
    emit(sliderloadingstate());
    await DioHelper.getData(
      url: Endpoint.slider,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      slidermodel = SliderModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(slidersuccessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(slidererrorstate());
    });
  }

  FavoModel? favomodel;
  getfavourite() async {
    emit(getfavoloadingstate());
    await DioHelper.getData(
      url: Endpoint.favou,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        favomodel = FavoModel.fromJson(value.data);
        emit(getfavosuccessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(getfavoerrorstate());
    });
  }

  AddFavoModel? addFavoModel;
  addToFav({required int id}) async {
    emit(addtofavoloadingstate());
    await DioHelper.postData(
      url: Endpoint.addfav,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addFavoModel = AddFavoModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(addtofavosuccessstate());
        getfavourite();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(addtofavoerrorstate());
    });
  }

  removeFav({required int id}) async {
    emit(removefavoloadingstate());
    await DioHelper.postData(
      url: Endpoint.removefav,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addFavoModel = AddFavoModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(removefavosuccessstate());
        getfavourite();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(removefavoerrorstate());
    });
  }

  CartModel? cartmodel;

  getcart() async {
    emit(cartloadingstate());
    await DioHelper.getData(
      url: Endpoint.cart,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      cartmodel = CartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(cartsuccessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(carterrorstate());
    });
  }

  AddCartModel? addcartmodel;
  addtocart({required int id}) async {
    emit(addtocartloadingstate());
    await DioHelper.postData(
      url: Endpoint.addcart,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addcartmodel = AddCartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(addtocartsuccessstate());
        getcart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(addtocarterrorstate());
    });
  }

  updatecart({required int id, required int quantity}) async {
    emit(updatecartloadingstate());
    await DioHelper.postData(
      url: Endpoint.updatecart,
      data: {'cart_item_id': id, 'quantity': quantity},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addcartmodel = AddCartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(updatecartsuccessstate());
        getcart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(updatecarterrorstate());
    });
  }

  RemoveCartModel? removecartmodel;
  removecart({required int id}) async {
    emit(removecartloadingstate());
    await DioHelper.postData(
      url: Endpoint.removecart,
      data: {'cart_item_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print(value.data['message']);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        removecartmodel = RemoveCartModel.fromJson(value.data);
        emit(removecartsuccessstate());
        getcart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422 ||
          error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['errors'];
      }
      emit(removecarterrorstate());
    });
  }

  CityModel? citymodel;
  getcity() async {
    emit(cityloadingstate());
    await DioHelper.getData(
      url: Endpoint.city,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      citymodel = CityModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(citysuccessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(cityerrorstate());
    });
  }

  int cityindex = 0;
  void filter(value) {
    cityindex = value;
    emit(filterstate());
  }

  PlaceOrderModel? placemodel;
  placeorder() async {
    emit(placeorderloadingstate());
    await DioHelper.postData(
      url: Endpoint.placeorder,
      data: {
        'governorate_id': 2,
        'phone': checkoutuserphone.text,
        'name': checkoutusername.text,
        'email': checkoutuseremail.text,
        'address': checkoutuseraddress.text
      },
    ).then((value) async {
      placemodel = PlaceOrderModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(placeorderSucceessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(placeorderErrorstate());
    });
  }

  updateProfile() async {
    emit(updateaccountloadingstate());
    await DioHelper.postData(
      url: Endpoint.updateprofile,
      data: {
        'name': username.text,
        'phone': userphone.text,
        'city': usercity.text,
        'address': useraddress.text,
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(updateaccountSucceessstate());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(updateaccountErrorstate());
    });
  }
}

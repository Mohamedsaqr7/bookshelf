import 'package:bloc/bloc.dart';
import 'package:bookshelf/Core/Services/Network/Diohelper.dart';
import 'package:bookshelf/Core/Services/Network/Endpoint.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authstate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/Services/local/Secure_storagee.dart';
import '../model/registermodel.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  bool obscure = true;

  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
  var regkey = GlobalKey<FormState>();

  RegisterModel? registerModel;
  register() async {
    emit(UserRegisterloadingState());
    await DioHelper.post(
            endpoint: Endpoint.register,
            data: {
              'name': name.text,
              'email': email.text,
              'password': password.text,
              'password_confirmation': confirmpassword.text
            },
            )
        .then((value) async {
      print(value.data);
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        registerModel = RegisterModel.fromJson(value.data);
      }

         await SecureStorage().storage.write(key: 'token', value: registerModel!.registerdata!.token);

      emit(UserRegistersuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioError && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UserRegisterErrorState());
    });
  }

  var logemail = TextEditingController();
  var logpassword = TextEditingController();
  var logkey = GlobalKey<FormState>();

  RegisterModel? logmodel;
  login() async{
    emit(UserlogloadingState());
    await DioHelper.post(endpoint: Endpoint.login, data: {
      'email': logemail.text,
      'password': logpassword.text,
    }).then((value) async {
      print(value.data);
      if (value.data['code'] == 200 || value.data['code'] == 201) {
              logmodel = RegisterModel.fromJson(value.data);

      }
      await SecureStorage().storage.write(key: 'token', value: registerModel!.registerdata!.token);

      emit(UserlogsuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioError && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UserlogErrorState());
    });
  }
}

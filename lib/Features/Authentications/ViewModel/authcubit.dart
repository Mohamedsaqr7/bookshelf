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

  var logemail = TextEditingController();
  var logpassword = TextEditingController();
  var logkey = GlobalKey<FormState>();
  AuthenticateModel? logmodel;

  AuthenticateModel? registerModel;
  register() async {
    emit(UserRegisterloadingState());
    await DioHelper.postData(
      url: Endpoint.register,
      data: {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'password_confirmation': confirmpassword.text
      },
    ).then((value) async {
      print(value.data);
      registerModel = AuthenticateModel.fromJson(value.data);
      if (registerModel!.status == 200) {
        print(registerModel!.data!.token);
        emit(UserRegistersuccessState());
      }

      await SecureStorage()
          .storage
          .write(key: 'token', value: registerModel!.data!.token);
      print(
          ' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
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

  login() async {
    emit(UserlogloadingState());
    await DioHelper.postData(url: Endpoint.login, data: {
      'email': logemail.text,
      'password': logpassword.text,
    }).then((value) async {
      print(value.data);
      logmodel = AuthenticateModel.fromJson(value.data);
      if (logmodel!.status == 200) {
        print(logmodel!.data!.token);
        emit(UserlogsuccessState());
      }
      await SecureStorage()
          .storage
          .write(key: 'token', value: logmodel!.data!.token);
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

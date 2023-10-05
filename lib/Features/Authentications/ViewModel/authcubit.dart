import 'package:bloc/bloc.dart';
import 'package:bookshelf/Core/Services/Network/Diohelper.dart';
import 'package:bookshelf/Core/Services/Network/Endpoint.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authstate.dart';
import 'package:bookshelf/Features/Authentications/model/verify_model.dart';
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
  var pin = TextEditingController();

  bool keepMecheckbox = false;
  void changecheck() {
    keepMecheckbox = !keepMecheckbox;
    emit(changecheckState());
  }

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

      }
        await SecureStorage()
            .storage
            .write(key: 'token', value: registerModel?.data?.token);
        emit(UserRegistersuccessState());
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

  AuthenticateModel? logmodel;
  login() async {
    emit(UserlogloadingState());
    await DioHelper.postData(url: Endpoint.login, data: {
      'email': logemail.text,
      'password': logpassword.text,
    }).then((value) async {
      print(value.data);
      logmodel = AuthenticateModel.fromJson(value.data);
      if (logmodel?.status == 200) {
        print(logmodel!.data!.token);
      }
      await SecureStorage()
          .storage
          .write(key: 'token', value: logmodel?.data?.token);
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

  Logout() async {
    emit(UserlogoutloadingState());
    await DioHelper.postData(
      url: Endpoint.logout,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print(value.data);
      if (value.statusCode == 200) {
        print(value.data['message']);
        emit(UserlogoutsuccessState());
      }
      await SecureStorage().storage.delete(key: 'token');
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UserlogoutErrorState());
    });
  }

  sendforgetpass() async {
    emit(forgetpassloadingState());
    await DioHelper.postData(
      url: Endpoint.forgetpass,
      data: {
        'email': logemail.text,
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(forgetpasssuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(forgetpassErrorState());
    });
  }

  VerifyModel? verifymodel;
  verifyemail() async {
    emit(VerifyloadingState());
    DioHelper.postData(
        url: Endpoint.verify,
        token: await SecureStorage().storage.read(key: 'token'),
        data: {
          "verify_code": int.parse(pin.text),
        }).then((value) async {
      print(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(VerifysuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(VerifysuccessState());
    });
  }

  resendverifyemail() async {
    emit(ResendverifyloadingState());
    await DioHelper.getData(
      url: Endpoint.resend,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(ResendverifysuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(ResendverifyErrorState());
    });
  }
}

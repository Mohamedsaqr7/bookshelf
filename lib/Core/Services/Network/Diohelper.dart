import 'package:dio/dio.dart';

import 'Endpoint.dart';

class DioHelper {
  static late final Dio dio;

  static Future<void> initState() async {
    dio = Dio(BaseOptions(
        baseUrl: Endpoint.baseurl,
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'}));
  }

  static Future<Response> get({
    required String endpoint /*url*/,
    Map<String, dynamic>? queryparams,
    String? token,
    Map? data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token'
    }; //تستخدم عشان لو عاوز ابعت هيدرز
    try {
      var response = await dio.get(endpoint, queryParameters: queryparams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put(
      {required String endpoint,
      Map<String, dynamic>? queryparams,
      String? token,
      Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token'
    }; //تستخدم عشان لو عاوز ابعت هيدرز
    try {
      var response =
          await dio.put(endpoint, queryParameters: queryparams, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? queryparams,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer$token '
      };
      var response = await dio.post(
        endpoint,
        queryParameters: queryparams,
        data: data,
      );
      return response;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  static Future<Response> delete(
      {required String endpoint,
      Map<String, dynamic>? queryparams,
      String? token,
      Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token'
    }; //تستخدم عشان لو عاوز ابعت هيدرز
    try {
      var response =
          await dio.delete(endpoint, queryParameters: queryparams, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

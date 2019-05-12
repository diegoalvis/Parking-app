import "dart:async";

import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/model/login.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/api/model/signin.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class AccountApi {

  final Dio _dio;

  AccountApi(this._dio);

  Future<Rspn<LoginRes>> login(LoginReq req) async {
    Response<Map<String, dynamic>> response = await _dio
        .post<Map<String, dynamic>>('/auth/login', data: req.toJson());
    return validate(response, parseLoginRes);
  }

  Future<Rspn<SigninRes>> signin(SigninReq req) async {
    req.type = 'citizen';
    req.username = req.email;
    Response<Map<String, dynamic>> response = await _dio
        .post<Map<String, dynamic>>('/auth/signin', data: req.toJson());
    return validate(response, parseSigninRes);
  }
}

LoginRes parseLoginRes(Map<String, dynamic> map) => LoginRes.fromJson(map);

SigninRes parseSigninRes(Map<String, dynamic> map) => SigninRes.fromJson(map);

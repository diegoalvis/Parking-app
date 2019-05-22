import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';

class BaseApi {
  Dio _dio;
  UserSession session;

  BaseApi(this._dio, this.session);

  Future<Response<Map<String, dynamic>>> get(String path, {Map<String, dynamic> query}) async {
    final auth = await _mkAuth(session);
    return await _dio.get<Map<String, dynamic>>(path, queryParameters: query, options: auth);
  }

  Future<Response<Map<String, dynamic>>> post(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.post<Map<String, dynamic>>(path, data: body, options: auth);
  }

  Future<Response<Map<String, dynamic>>> put(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.put<Map<String, dynamic>>(path, data: body, options: auth);
  }

  Future<Response<Map<String, dynamic>>> delete(String path) async {
    final auth = await _mkAuth(session);
    return await _dio.delete<Map<String, dynamic>>(path, options: auth);
  }

  Future<Options> _mkAuth(UserSession session) async {
    final token = await session.token;
    return Options(headers: {'Authorization': token});
    //return Options(headers: {'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjZTFhZWUzMWE1ODQ2NmQ2N2I3ZjI0NCIsImlhdCI6MTU1ODI5NDI0M30.-QQB5tainSoAuclOEHTYDyeT-r7hM19PFOTPzFxsOD8"});
  }
}

import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';

class BaseApi {
  Dio _dio;
  UserSession session;

  BaseApi(this._dio, this.session);

  Future<Response<Map<String, dynamic>>> get(String path, {Map<String, dynamic> query}) async {
    final auth = await _mkAuth(session);
    return await _dio.get<Map<String, dynamic>>(path, queryParameters: query, options: auth).catchError((error) {
      if ((error as DioError).response.statusCode == 401) {
        session.clear();
      }
    });
  }

  Future<Response<Map<String, dynamic>>> post(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.post<Map<String, dynamic>>(path, data: body, options: auth).catchError((error) {
      if ((error as DioError).response.statusCode == 401) {
        session.clear();
      }
    });
  }

  Future<Response<Map<String, dynamic>>> put(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.put<Map<String, dynamic>>(path, data: body, options: auth).catchError((error) {
      if ((error as DioError).response.statusCode == 401) {
        session.clear();
      }
    });
  }

  Future<Response<Map<String, dynamic>>> delete(String path) async {
    final auth = await _mkAuth(session);
    return await _dio.delete<Map<String, dynamic>>(path, options: auth).catchError((error) {
      if ((error as DioError).response.statusCode == 401) {
        session.clear();
      }
    });
  }

  Future<Options> _mkAuth(UserSession session) async {
    final token = await session.token;
    return Options(headers: {'Authorization': token});
  }
}

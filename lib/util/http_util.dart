import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

Future<Rspn<T>> validate<T>(Response response, ComputeCallback<Map<String, dynamic>, T> callback) async {
  if ((response.statusCode >= 200 && response.statusCode < 300) || response.statusCode == 304) {
    final body = response.data;
    bool success = body["success"] as bool;
    int error = body["error"] as int;

    T data;
    if (body["data"] != null) {
      data = await compute<Map<String, dynamic>, T>(callback, body["data"]);
    }

    return Rspn(success: success, data: data, error: error);
  } else if (response.statusCode == 404) {
    throw AppException(cause: "Registro no encontrado");
  } else {
    throw AppException(cause: "Error al realizar petición, intenta de nuevo");
  }
}

Future<Rspn<T>> validateList<T>(Response response, ComputeCallback<List<Map<String, dynamic>>, T> callback) async {
  if ((response.statusCode >= 200 && response.statusCode < 300) || response.statusCode == 304) {
    final body = response.data;
    bool success = body["success"] as bool;
    int error = body["error"] as int;

    T data;
    if (body["data"] != null) {
      data = await compute<List<Map<String, dynamic>>, T>(callback, body["data"]);
    }

    return Rspn(success: success, data: data, error: error);
  } else if (response.statusCode == 404) {
    throw AppException(cause: "Registro no encontrado");
  } else {
    throw AppException(cause: "Error al realizar petición, intenta de nuevo");
  }
}

Future<Rspn<T>> validateValue<T>(Response response) async {
  if (response.statusCode == 202) {
    final body = response.data;
    bool success = body["success"] as bool;
    int error = body["error"] as int;
    T data = body["data"] != null ? body["data"] as T : null;
    return Rspn(success: success, data: data, error: error);
  } else if (response.statusCode == 404) {
    throw AppException(cause: "Registro no encontrado");
  } else {
    throw AppException(cause: "Error al realizar petición, intenta de nuevo");
  }
}



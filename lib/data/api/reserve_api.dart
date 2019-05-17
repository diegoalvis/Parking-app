import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/base_api.dart';
import 'package:oneparking_citizen/data/api/model/reserve.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class ReserveApi extends BaseApi{

  ReserveApi(Dio dio, UserSession session) : super(dio, session);

  Future<Rspn<ReserveRes>> reserve(ReserveReq req) async{
    Response res = await post('citizen/reserve', body: req.toJson());
    return validate(res, parseReserveRes);
  }

  Future<Rspn<ReserveStopRes>> reserveStop(String id) async{
    Response res = await post('citizen/reserve/stop/$id');
    return validate(res, parseReserveStopRes);
  }
}

ReserveRes parseReserveRes(Map<String, dynamic> json) => ReserveRes.fromJson(json);
ReserveStopRes parseReserveStopRes(Map<String, dynamic> json) => ReserveStopRes.fromJson(json);
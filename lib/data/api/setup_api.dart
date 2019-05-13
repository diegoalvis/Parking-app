import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/base_api.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/api/model/setup.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class SetupApi extends BaseApi {
  SetupApi(Dio dio, UserSession session) : super(dio, session);

  Future<Rspn<Setup>> loadSetup(bool onlyVersion, {int version}) async {
    Response res = await get('', query: {'onlyVersion': onlyVersion, 'version': version});
    return validate(res, parseSetup);
  }
}

Setup parseSetup(Map<String, dynamic> json) {
  return Setup.fromJson(json);
}

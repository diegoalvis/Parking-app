import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/base_api.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/models/incident.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class IncidentApi extends BaseApi{

  IncidentApi(Dio dio, UserSession session):super(dio, session);

  Future<Rspn<String>> addIncident(Incident req) async {
    Response response = await post('/incidents', body: req.toJson());
    return validateValue(response);
  }

}

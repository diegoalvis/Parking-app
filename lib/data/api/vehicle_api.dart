import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/base_api.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class VehicleApi extends BaseApi {
  VehicleApi(Dio dio, UserSession session) : super(dio, session);

  Future<Rspn<String>> add(VehicleBase req) async {
    Response response = await post('/citizens/vehicles', body: req.toJson());
    return validateValue(response);
  }

  Future<Rspn<String>> remove(String plate) async {
    Response response = await delete('/citizens/vehicles/${Uri.encodeComponent(plate)}');
    return validateValue(response);
  }

  Future<Rspn<List<VehicleBase>>> all() async {
    final id = await session.id;
    Response response = await get('/citizens/$id/vehicles');
    return validateList(response, parseVehicles);
  }
}

List<Vehicle> parseVehicles(List<Map<String, dynamic>> json) =>
    json.map((jn) => VehicleBase.fromJson(jn)).toList();

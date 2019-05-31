import 'package:oneparking_citizen/data/api/incident_api.dart';
import 'package:oneparking_citizen/data/models/incident.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class IncidentRepository{

  IncidentApi _api;
  UserSession _session;
  ErrorCodes _errors;

  IncidentRepository(this._api, this._session, this._errors);

  Future<String> report(String image, String observations, IncidentZone zone) async{
    String name = await _session.name;
    String phone = await _session.phone;
    final user = IncidentUser(name:name, phone:phone);
    final rspn = await _api.addIncident(Incident(image: image,observations: observations, reportUser: user, zone: zone));
    if (!rspn.success) _errors.validateError(rspn.error);
    return rspn.data;
  }

}
import 'package:oneparking_citizen/data/api/incident_api.dart';
import 'package:oneparking_citizen/data/models/incident.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class IncidentRepository{

  IncidentApi _api;
  ErrorCodes _errors;

  IncidentRepository(this._api);

  Future<String> report(Incident incident) async{
    final rspn = await _api.addIncident(incident);
    if (!rspn.success) _errors.validateError(rspn.error);
    return rspn.data;
  }

}
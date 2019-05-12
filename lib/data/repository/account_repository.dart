import 'package:oneparking_citizen/data/api/account_api.dart';
import 'package:oneparking_citizen/data/api/model/login.dart';
import 'package:oneparking_citizen/data/api/model/signin.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/data/models/user.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class AccountRepository {
  VehicleDao _vehicleDao;
  AccountApi _accountApi;
  UserSession _session;
  ErrorCodes _errors;
  SigninReq signinReq = SigninReq();

  AccountRepository(
      this._session, this._accountApi, this._vehicleDao, this._errors);

  Future<bool> login(String email, String password) async {
    final rspn = await _accountApi.login(
        LoginReq(username: email, password: password, roles: ['Cliente']));

    if (!rspn.success) _errors.validateError(rspn.error);

    final user = rspn.data.user;
    _session.init(rspn.data.token, user);
    await _vehicleDao.deleteAll();
    final cars = user.vehicles.map((c) => Vehicle.fromVehicle(c)).toList();
    await _vehicleDao.insertMany(cars);

    return rspn.success;
  }

  Future<bool> signin() async {
    final rspn = await _accountApi.signin(signinReq);

    if (!rspn.success) _errors.validateError(rspn.error);
    _session.init(
        rspn.data.token,
        User(
          id: rspn.data.id,
          document: signinReq.document,
          phone: signinReq.phone,
          name: signinReq.name,
          disability: signinReq.disability,
          email: signinReq.email,
        ));
    await _vehicleDao.deleteAll();
    return rspn.success;
  }

  void addPhone(String phone) {
    signinReq.phone = phone;
  }

  void addIdentify(String name, String doc, bool disability) {
    signinReq.name = name;
    signinReq.document = doc;
    signinReq.disability = disability;
  }

  void addCredentials(String email, String password) {
    signinReq.email = email;
    signinReq.password = password;
  }

  void clearSign(){
    signinReq = SigninReq();
  }
}

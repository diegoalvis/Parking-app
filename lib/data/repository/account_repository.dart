import 'package:oneparking_citizen/data/api/account_api.dart';
import 'package:oneparking_citizen/data/api/model/login.dart';
import 'package:oneparking_citizen/data/api/model/signin.dart';
import 'package:oneparking_citizen/data/db/dao/car_dao.dart';
import 'package:oneparking_citizen/data/models/car.dart';
import 'package:oneparking_citizen/data/models/user.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class AccountRepository {
  CarDao _carDao;
  AccountApi _accountApi;
  UserSession _session;
  ErrorCodes _errors;
  SigninReq signinReq = SigninReq();

  AccountRepository(
      this._session, this._accountApi, this._carDao, this._errors);

  Future<bool> login(String email, String password) async {
    final rspn = await _accountApi.login(
        LoginReq(username: email, password: password, roles: ['Cliente']));

    if (!rspn.success) _errors.validateError(rspn.error);

    final user = rspn.data.user;
    _session.init(rspn.data.token, user);
    await _carDao.deleteAll();
    final cars = user.vehiculos.map((c) => CarLocal.fromCar(c)).toList();
    await _carDao.insertMany(cars);

    return rspn.success;
  }

  Future<bool> signin() async {
    final rspn = await _accountApi.signin(signinReq);

    if (!rspn.success) _errors.validateError(rspn.error);
    _session.init(
        rspn.data.token,
        User(
          id: rspn.data.id,
          cedula: signinReq.cedula,
          celular: signinReq.celular,
          nombre: signinReq.nombre,
          discapasitado: signinReq.discapasitado,
          email: signinReq.email,
        ));
    await _carDao.deleteAll();
    return rspn.success;
  }

  void addPhone(String phone) {
    signinReq.celular = phone;
  }

  void addIdentify(String name, String doc, bool disability) {
    signinReq.nombre = name;
    signinReq.cedula = doc;
    signinReq.discapasitado = disability;
  }

  void addCredentials(String email, String password) {
    signinReq.email = email;
    signinReq.password = password;
  }

  void clearSign(){
    signinReq = SigninReq();
  }
}

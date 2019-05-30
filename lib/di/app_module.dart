import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/account_api.dart';
import 'package:oneparking_citizen/data/api/bill_api.dart';
import 'package:oneparking_citizen/data/api/incident_api.dart';
import 'package:oneparking_citizen/data/api/reserve_api.dart';
import 'package:oneparking_citizen/data/api/setup_api.dart';
import 'package:oneparking_citizen/data/api/vehicle_api.dart';
import 'package:oneparking_citizen/data/api/zone_api.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/db/dao/config_dao.dart';
import 'package:oneparking_citizen/data/db/dao/reserve_dao.dart';
import 'package:oneparking_citizen/data/db/dao/schedule_dao.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/db/dao/zone_dao.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';
import 'package:oneparking_citizen/data/repository/bill_repository.dart';
import 'package:oneparking_citizen/data/repository/incident_repository.dart';
import 'package:oneparking_citizen/data/repository/info_repository.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/data/repository/setup_repository.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/data/repository/zone_repository.dart';
import 'package:oneparking_citizen/pages/main/main_bloc.dart';
import 'package:oneparking_citizen/util/dialog-util.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(UserSession())
      ..bindSingleton(ErrorCodes())
      /*..bindSingleton((injector, params) {
        final dio = Dio(BaseOptions(baseUrl: "http://13.68.223.69/api/v1"));
        dio.interceptors.add(
          InterceptorsWrapper(
            onError: (e) => Exception("Error de comunicación :("),
          ),
        );
        return dio;
      })*/
      ..bindSingleton(Dio(BaseOptions(baseUrl: "http://13.68.223.69/api/v1")))
      ..bindSingleton('http://13.68.223.69/socket/zones', name: 'url_socket')
      ..bindSingleton(AppDatabase())
      //Database
      ..bindLazySingleton((injector, params) => VehicleDao(injector.get()))
      ..bindLazySingleton((injector, params) => ConfigDao(injector.get()))
      ..bindLazySingleton((injector, params) => ReserveDao(injector.get()))
      ..bindLazySingleton((injector, params) => ScheduleDao(injector.get()))
      ..bindLazySingleton((injector, params) => ZoneDao(injector.get()))
      //Api
      ..bindLazySingleton((injector, params) => AccountApi(injector.get()))
      ..bindLazySingleton(
          (injector, params) => BillApi(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => IncidentApi(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => ReserveApi(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => SetupApi(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => VehicleApi(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => ZoneApi(injector.get(), injector.get()))
      //Repositories
      ..bindLazySingleton((injector, params) => AccountRepository(
          injector.get(), injector.get(), injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => BillRepository(injector.get(), injector.get()))
      ..bindLazySingleton(
          (injector, params) => IncidentRepository(injector.get()))
      ..bindLazySingleton(
          (injector, params) => InfoRepository(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => ReserveRepository(
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get()))
      ..bindLazySingleton((injector, params) => SetupRepository(
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get(),
          injector.get()))
      ..bindLazySingleton((injector, params) =>
          VehicleRepository(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => DialogUtil())
      ..bindLazySingleton((injector, params) => ZoneRepository(injector.get(),
          injector.get(), injector.get(), injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => MainBloc(injector.get()));
  }
}

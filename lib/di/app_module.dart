import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/account_api.dart';
import 'package:oneparking_citizen/data/db/app_database.dart';
import 'package:oneparking_citizen/data/db/dao/vehicle_dao.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';
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
      ..bindLazySingleton((injector, params) => AccountApi(injector.get()))
      ..bindSingleton(AppDatabase())
      ..bindLazySingleton((injector, params) => VehicleDao(injector.get()))
      ..bindLazySingleton((injector, params) => AccountRepository(
            injector.get(),
            injector.get(),
            injector.get(),
            injector.get(),
          ));
  }
}

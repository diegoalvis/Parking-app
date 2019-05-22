import 'package:dio/dio.dart';
import 'package:oneparking_citizen/data/api/base_api.dart';
import 'package:oneparking_citizen/data/api/model/rspn.dart';
import 'package:oneparking_citizen/data/models/bill.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/http_util.dart';

class BillApi extends BaseApi {
  BillApi(Dio dio, UserSession session) : super(dio, session);

  Future<Rspn<List<Bill>>> all({int limit: 50, int skip: 0}) async {
    final id = await session.id;
    Response res = await get('/citizens/$id/transactions', query: {'limit': limit, 'skip': skip});
    return validateList(res, parseBill);
  }

  Future<Rspn<List<Debt>>> allDebt() async {
    Response res = await get('/debts/self');
    return validateList(res, parseDebt);
  }
}

List<Bill> parseBill(List<Map<String, dynamic>> json) =>
    json.map((x) => Bill.fromJson(x)).toList();

List<Debt> parseDebt(List<Map<String, dynamic>> json) =>
    json.map((x) => Debt.fromJson(x)).toList();

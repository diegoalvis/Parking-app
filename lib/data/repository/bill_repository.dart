import 'package:oneparking_citizen/data/api/bill_api.dart';
import 'package:oneparking_citizen/data/models/bill.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class BillRepository{

  BillApi _api;
  ErrorCodes _errors;

  BillRepository(this._api, this._errors);

  Future<List<Bill>> _getBills() async{
    final rspn = await _api.all();
    if (!rspn.success) _errors.validateError(rspn.error);
    return rspn.data;
  }

  Future<List<Debt>> _getDebts() async{
    final rspn = await _api.allDebt();
    if (!rspn.success) _errors.validateError(rspn.error);
    return rspn.data;
  }

  Future<BillInfo> get() async{
    final bills = await _getBills();
    final debts = await _getDebts();
    return BillInfo(bills, debts);
  }
}

class BillInfo{
  List<Bill> bills;
  List<Debt> debts;

  BillInfo(this.bills, this.debts);
}
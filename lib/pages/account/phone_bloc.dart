import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';

class PhoneEvent{
  String phone;
  PhoneEvent({this.phone});
}

class PhoneBloc extends Bloc<PhoneEvent, int>{

  AccountRepository _repository;

  PhoneBloc(this._repository);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(PhoneEvent event) async* {
    if(event.phone != null){
      _repository.addPhone(event.phone);
    }else{
      _repository.clearSign();
    }
  }

}

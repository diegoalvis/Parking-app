import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';

class RegisterOneEvent{
  String name;
  String doc;
  bool disability;
  RegisterOneEvent({this.name, this.doc, this.disability});
}

class RegisterOneBloc extends Bloc<RegisterOneEvent, int>{

  AccountRepository _repository;

  RegisterOneBloc(this._repository);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(RegisterOneEvent event) async* {
    if(event.name != null){
      _repository.addIdentify(event.name, event.doc, event.disability);
    }
  }

}

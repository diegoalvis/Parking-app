import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class RegisterTwoEvent{
  String email;
  String pass;
  RegisterTwoEvent({this.email, this.pass});
}

class RegisterTwoBloc extends Bloc<RegisterTwoEvent, BaseState>{

  AccountRepository _repository;

  RegisterTwoBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RegisterTwoEvent event) async* {
    try{
      _repository.addCredentials(event.email, event.pass);
      yield LoadingState();
      await _repository.signin();
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }

}

import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/account_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class LoginEvent {
  String email;
  String pass;

  LoginEvent({this.email, this.pass});
}

class LoginBloc extends Bloc<LoginEvent, BaseState> {

  AccountRepository _repository;

  LoginBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(LoginEvent event) async*{
    try{
      yield LoadingState();
      await _repository.login(event.email, event.pass);
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }

  }

}

import 'package:equatable/equatable.dart';

class BaseState extends Equatable{}
class InitialState extends BaseState{
  @override
  String toString() => 'state-initial';
}
class LoadingState extends BaseState{
  @override
  String toString() => 'state-loading';
}
class SuccessState extends BaseState{
  @override
  String toString() => 'state-success';
}
class ErrorState extends BaseState{
  String msg;
  ErrorState(this.msg);
  @override
  String toString() => 'state-error';
}

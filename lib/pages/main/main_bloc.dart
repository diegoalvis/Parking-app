import 'package:bloc/bloc.dart';

class MainBloc extends Bloc<int, int> {
  @override
  int get initialState => 4;

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}

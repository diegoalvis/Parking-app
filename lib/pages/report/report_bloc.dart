import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'dart:io';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/data/models/incident.dart';
import 'package:oneparking_citizen/data/repository/incident_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class IncidentEvent {
  final File image;
  final String observations;
  final IncidentZone zone;

  IncidentEvent(this.image, this.observations, this.zone);

  @override
  String toString() => 'Incident';
}

class IncidentBloc extends Bloc<IncidentEvent, BaseState> {
  IncidentRepository _repository;

  IncidentBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(IncidentEvent event) async* {
    final bytes = await event.image.readAsBytes();
    String imageBase = base64Encode(bytes);

    try {
      yield LoadingState();
      await _repository.report(imageBase, event.observations, event.zone);
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 2));
      yield InitialState();
    }
  }
}

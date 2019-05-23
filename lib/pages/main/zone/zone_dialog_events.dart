import 'package:equatable/equatable.dart';
import 'package:oneparking_citizen/data/models/zone.dart';

abstract class ZoneDialogEvent extends Equatable {}

class ReadyZone extends ZoneDialogEvent {
  String id;
  String type;

  ReadyZone(this.id, this.type);

  @override
  String toString() => "ReadyEvent";
}

class ReserveZone extends ZoneDialogEvent {
  Zone zone;
  ReserveZone(this.zone);

  @override
  String toString() => "ReserveEvent";
}
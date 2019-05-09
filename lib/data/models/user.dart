import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/car.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User{
  @JsonKey(name: "_id")
  String id;
  String nombre;
  String cedula;
  String celular;
  bool discapasitado;
  String email;
  int saldo;
  DateTime ultimatransaccion;
  bool validado;
  List<Car> vehiculos;

  User({this.id, this.nombre, this.cedula, this.celular, this.discapasitado, this.email, this.saldo, this.ultimatransaccion, this.validado});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}


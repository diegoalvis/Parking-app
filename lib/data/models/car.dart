import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car{
  String placa;
  String marca;

  Car({this.placa, this.marca});

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);
}

@JsonSerializable(nullable: true)
class CarLocal extends Car{
  int id;
  bool selected;

  CarLocal({this.id, String placa, String marca, this.selected}):super(placa: placa, marca:marca);

  CarLocal.fromCar(Car car){
    selected = false;
    placa = car.placa;
    marca = car.marca;
  }

  factory CarLocal.fromJson(Map<String, dynamic> json) => _$CarLocalFromJson(json);
  Map<String, dynamic> toJson() => _$CarLocalToJson(this);
}
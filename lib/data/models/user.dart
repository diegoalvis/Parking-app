import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User{
  @JsonKey(name: "_id")
  String id;
  String name;
  String document;
  String phone;
  bool disability;
  String email;
  bool validated;
  List<Vehicle> vehicles;

  User({this.id, this.name, this.document, this.phone, this.disability, this.email, this.validated});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}


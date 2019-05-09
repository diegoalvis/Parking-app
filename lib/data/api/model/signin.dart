import 'package:json_annotation/json_annotation.dart';

part 'signin.g.dart';

@JsonSerializable()
class SigninReq{
  String tipo;
  String nombre;
  String cedula;
  String celular;
  String email;
  String usuario;
  String password;
  bool discapasitado;

  SigninReq({this.tipo, this.nombre, this.cedula, this.celular, this.email, this.usuario, this.password, this.discapasitado});

  factory SigninReq.fromJson(Map<String, dynamic> json) => _$SigninReqFromJson(json);
  Map<String, dynamic> toJson() => _$SigninReqToJson(this);
}

@JsonSerializable()
class SigninRes{
    String token;
    String id;

    SigninRes({this.token, this.id});

    factory SigninRes.fromJson(Map<String, dynamic> json) => _$SigninResFromJson(json);
    Map<String, dynamic> toJson() => _$SigninResToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninReq _$SigninReqFromJson(Map<String, dynamic> json) {
  return SigninReq(
      tipo: json['tipo'] as String,
      nombre: json['nombre'] as String,
      cedula: json['cedula'] as String,
      celular: json['celular'] as String,
      email: json['email'] as String,
      usuario: json['usuario'] as String,
      password: json['password'] as String,
      discapasitado: json['discapasitado'] as bool);
}

Map<String, dynamic> _$SigninReqToJson(SigninReq instance) => <String, dynamic>{
      'tipo': instance.tipo,
      'nombre': instance.nombre,
      'cedula': instance.cedula,
      'celular': instance.celular,
      'email': instance.email,
      'usuario': instance.usuario,
      'password': instance.password,
      'discapasitado': instance.discapasitado
    };

SigninRes _$SigninResFromJson(Map<String, dynamic> json) {
  return SigninRes(token: json['token'] as String, id: json['id'] as String);
}

Map<String, dynamic> _$SigninResToJson(SigninRes instance) =>
    <String, dynamic>{'token': instance.token, 'id': instance.id};

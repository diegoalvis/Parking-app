// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['_id'] as String,
      nombre: json['nombre'] as String,
      cedula: json['cedula'] as String,
      celular: json['celular'] as String,
      discapasitado: json['discapasitado'] as bool,
      email: json['email'] as String,
      saldo: json['saldo'] as int,
      ultimatransaccion: json['ultimatransaccion'] == null
          ? null
          : DateTime.parse(json['ultimatransaccion'] as String),
      validado: json['validado'] as bool)
    ..vehiculos = (json['vehiculos'] as List)
        ?.map((e) => e == null ? null : Car.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'cedula': instance.cedula,
      'celular': instance.celular,
      'discapasitado': instance.discapasitado,
      'email': instance.email,
      'saldo': instance.saldo,
      'ultimatransaccion': instance.ultimatransaccion?.toIso8601String(),
      'validado': instance.validado,
      'vehiculos': instance.vehiculos
    };

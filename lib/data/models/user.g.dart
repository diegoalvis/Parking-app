// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      document: json['document'] as String,
      phone: json['phone'] as String,
      disability: json['disability'] as bool,
      email: json['email'] as String,
      validated: json['validated'] as bool)
    ..vehicles = (json['vehicles'] as List)
        ?.map((e) =>
            e == null ? null : Vehicle.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'document': instance.document,
      'phone': instance.phone,
      'disability': instance.disability,
      'email': instance.email,
      'validated': instance.validated,
      'vehicles': instance.vehicles
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninReq _$SigninReqFromJson(Map<String, dynamic> json) {
  return SigninReq(
      type: json['type'] as String,
      name: json['name'] as String,
      document: json['document'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      disability: json['disability'] as bool);
}

Map<String, dynamic> _$SigninReqToJson(SigninReq instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'document': instance.document,
      'phone': instance.phone,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'disability': instance.disability
    };

SigninRes _$SigninResFromJson(Map<String, dynamic> json) {
  return SigninRes(token: json['token'] as String, id: json['id'] as String);
}

Map<String, dynamic> _$SigninResToJson(SigninRes instance) =>
    <String, dynamic>{'token': instance.token, 'id': instance.id};

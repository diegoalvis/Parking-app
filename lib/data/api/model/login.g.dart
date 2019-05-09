// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReq _$LoginReqFromJson(Map<String, dynamic> json) {
  return LoginReq(
      username: json['username'] as String,
      password: json['password'] as String,
      roles: (json['roles'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$LoginReqToJson(LoginReq instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'roles': instance.roles
    };

LoginRes _$LoginResFromJson(Map<String, dynamic> json) {
  return LoginRes(
      token: json['token'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LoginResToJson(LoginRes instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

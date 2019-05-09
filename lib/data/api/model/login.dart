import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/user.dart';

part 'login.g.dart';

@JsonSerializable(nullable: true)
class LoginReq{
  String username;
  String password;
  List<String> roles;

  LoginReq({this.username, this.password, this.roles});

  factory LoginReq.fromJson(Map<String, dynamic> json) => _$LoginReqFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqToJson(this);
}

@JsonSerializable(nullable: true)
class LoginRes{

  String token;
  User user;

  LoginRes({this.token, this.user});

  factory LoginRes.fromJson(Map<String, dynamic> json) => _$LoginResFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResToJson(this);
}
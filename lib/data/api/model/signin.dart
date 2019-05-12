import 'package:json_annotation/json_annotation.dart';

part 'signin.g.dart';

@JsonSerializable()
class SigninReq{
  String type;
  String name;
  String document;
  String phone;
  String email;
  String username;
  String password;
  bool disability;

  SigninReq({this.type, this.name, this.document, this.phone, this.email, this.username, this.password, this.disability});

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

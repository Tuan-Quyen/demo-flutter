import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthencationModels{
  final bool success;
  final String expiredAt;
  final String requestToken;

  AuthencationModels(this.success, this.requestToken, this.expiredAt);

  factory AuthencationModels.fromJson(Map<String, dynamic> json) => new Welcome(
    success: json["success"],
    expiresAt: json["expires_at"],
    requestToken: json["request_token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "expires_at": expiresAt,
    "request_token": requestToken,
  };
}
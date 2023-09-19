import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'linkedin_access_token.g.dart';

@JsonSerializable()
class LinkedInAccessToken extends Equatable {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  final String? scope;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'id_token')
  final String? idToken;

  const LinkedInAccessToken({
    this.accessToken,
    this.expiresIn,
    this.scope,
    this.tokenType,
    this.idToken,
  });

  factory LinkedInAccessToken.fromJson(Map<String, dynamic> json) {
    return _$LinkedInAccessTokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LinkedInAccessTokenToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      accessToken,
      expiresIn,
      scope,
      tokenType,
      idToken,
    ];
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linkedin_access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedInAccessToken _$LinkedInAccessTokenFromJson(Map<String, dynamic> json) =>
    LinkedInAccessToken(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      scope: json['scope'] as String?,
      tokenType: json['token_type'] as String?,
      idToken: json['id_token'] as String?,
    );

Map<String, dynamic> _$LinkedInAccessTokenToJson(
        LinkedInAccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'scope': instance.scope,
      'token_type': instance.tokenType,
      'id_token': instance.idToken,
    };

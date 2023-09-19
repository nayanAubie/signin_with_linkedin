// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linkedin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedInUser _$LinkedInUserFromJson(Map<String, dynamic> json) => LinkedInUser(
      sub: json['sub'] as String?,
      emailVerified: json['email_verified'] as bool?,
      name: json['name'] as String?,
      locale: json['locale'] == null
          ? null
          : LinkedInLocale.fromJson(json['locale'] as Map<String, dynamic>),
      givenName: json['given_name'] as String?,
      familyName: json['family_name'] as String?,
      email: json['email'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$LinkedInUserToJson(LinkedInUser instance) =>
    <String, dynamic>{
      'sub': instance.sub,
      'email_verified': instance.emailVerified,
      'name': instance.name,
      'locale': instance.locale,
      'given_name': instance.givenName,
      'family_name': instance.familyName,
      'email': instance.email,
      'picture': instance.picture,
    };

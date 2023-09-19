import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'linkedin_locale.dart';

part 'linkedin_user.g.dart';

@JsonSerializable()
class LinkedInUser extends Equatable {
  final String? sub;
  @JsonKey(name: 'email_verified')
  final bool? emailVerified;
  final String? name;
  final LinkedInLocale? locale;
  @JsonKey(name: 'given_name')
  final String? givenName;
  @JsonKey(name: 'family_name')
  final String? familyName;
  final String? email;
  final String? picture;

  const LinkedInUser({
    this.sub,
    this.emailVerified,
    this.name,
    this.locale,
    this.givenName,
    this.familyName,
    this.email,
    this.picture,
  });

  factory LinkedInUser.fromJson(Map<String, dynamic> json) {
    return _$LinkedInUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LinkedInUserToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sub,
      emailVerified,
      name,
      locale,
      givenName,
      familyName,
      email,
      picture,
    ];
  }
}

import 'package:equatable/equatable.dart';

import 'linkedin_locale.dart';

/// LinkedIn user details.
class LinkedInUser extends Equatable {
  /// Unique identifier of the user.
  final String? sub;

  /// Whether the user's email address has been verified.
  final bool? emailVerified;

  /// Full name of the user.
  final String? name;

  /// Locale of the user.
  final LinkedInLocale? locale;

  /// First name of the user.
  final String? givenName;

  /// Last name of the user.
  final String? familyName;

  /// Email address of the user.
  final String? email;

  /// Network URL of the user's profile picture.
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
    return LinkedInUser(
      sub: json['sub'] as String?,
      emailVerified: json['email_verified'] as bool?,
      name: json['name'] as String?,
      locale:
          json['locale'] == null
              ? null
              : LinkedInLocale.fromJson(json['locale'] as Map<String, dynamic>),
      givenName: json['given_name'] as String?,
      familyName: json['family_name'] as String?,
      email: json['email'] as String?,
      picture: json['picture'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sub': sub,
    'email_verified': emailVerified,
    'name': name,
    'locale': locale,
    'given_name': givenName,
    'family_name': familyName,
    'email': email,
    'picture': picture,
  };

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

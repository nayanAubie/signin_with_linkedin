import 'package:equatable/equatable.dart';

/// LinkedIn access token details.
class LinkedInTokenInfo extends Equatable {
  /// Access token.
  final String accessToken;

  /// The number of seconds remaining until the token expires.
  /// Currently, all access tokens are issued with a 60-day lifespan.
  final int expiresIn;

  /// Space-delimited list of member permissions your application has
  /// requested on behalf of the user.
  final String scope;

  /// Type of the token. Always `Bearer`.
  final String tokenType;

  /// The ID token is a JWT token that contains information about the user.
  final String idToken;

  const LinkedInTokenInfo({
    required this.accessToken,
    required this.expiresIn,
    required this.scope,
    required this.tokenType,
    required this.idToken,
  });

  factory LinkedInTokenInfo.fromJson(Map<String, dynamic> json) {
    return LinkedInTokenInfo(
      accessToken: json['access_token'] as String,
      expiresIn: json['expires_in'] as int,
      scope: json['scope'] as String,
      tokenType: json['token_type'] as String,
      idToken: json['id_token'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'expires_in': expiresIn,
    'scope': scope,
    'token_type': tokenType,
    'id_token': idToken,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [accessToken, expiresIn, scope, tokenType, idToken];
  }
}

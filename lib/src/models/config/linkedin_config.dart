import 'package:uuid/uuid.dart';

/// LinkedIn configuration class.
final class LinkedInConfig {
  /// Client ID of the LinkedIn application.
  final String clientId;

  /// Client secret of the LinkedIn application.
  final String clientSecret;

  /// Redirect URL of the LinkedIn application.
  final String redirectUrl;

  /// Requested scopes. e.g ['openid', 'profile', 'email']
  final List<String> scope;

  /// Generated UUID for state.
  final String state = const Uuid().v4();

  LinkedInConfig({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    required this.scope,
  });

  /// Authorization URL for LinkedIn.
  String get authorizationUrl =>
      'https://www.linkedin.com/oauth/v2/authorization?'
      'response_type=code&'
      'client_id=$clientId&'
      'redirect_uri=$redirectUrl&'
      'state=$state&'
      'scope=${scope.join('%20')}';
}

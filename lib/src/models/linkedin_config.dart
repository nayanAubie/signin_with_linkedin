import 'package:uuid/uuid.dart';

/// LinkedIn configuration class that helps to make initial url and API calls
/// for user authorization
final class LinkedInConfig {
  final String clientId;
  final String clientSecret;
  final String redirectUrl;
  final List<String> scope;

  LinkedInConfig({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    required this.scope,
  });

  String get authorizationUrl =>
      'https://www.linkedin.com/oauth/v2/authorization?'
      'response_type=code&'
      'client_id=$clientId&'
      'redirect_uri=$redirectUrl&'
      'state=${const Uuid().v4()}&'
      'scope=${scope.join('%20')}';
}

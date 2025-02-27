import 'dart:convert';

import '../../signin_with_linkedin.dart';
import 'http_client/http_client_factory.dart'
    if (dart.library.js_interop) 'http_client/http_client_factory_web.dart';

/// Manages all the API calls and response handling.
final class LinkedInApiClient {
  final _client = httpClient();

  LinkedInApiClient();

  /// Get the access token from LinkedIn.
  Future<(LinkedInTokenInfo?, LinkedInAuthError?)> getAccessToken({
    required LinkedInConfig config,
    required String code,
  }) async {
    final response = await _client.post(
      Uri(
        scheme: 'https',
        host: 'www.linkedin.com',
        path: 'oauth/v2/accessToken',
      ),
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': config.clientId,
        'client_secret': config.clientSecret,
        'redirect_uri': config.redirectUrl,
      },
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    final statusCode = response.statusCode;
    final data = json.decode(response.body) as Map<String, dynamic>;

    if (statusCode == 200) {
      return (LinkedInTokenInfo.fromJson(data), null);
    }
    return (null, LinkedInAuthError.fromData(statusCode, data));
  }

  /// Get the user info from LinkedIn.
  Future<(LinkedInUser?, LinkedInProfileError?)> getUserInfo({
    required String tokenType,
    required String token,
  }) async {
    final response = await _client.get(
      Uri(scheme: 'https', host: 'api.linkedin.com', path: 'v2/userinfo'),
      headers: {'Authorization': '$tokenType $token'},
    );

    final statusCode = response.statusCode;
    final data = json.decode(response.body) as Map<String, dynamic>;

    if (statusCode == 200) {
      return (LinkedInUser.fromJson(data), null);
    }
    return (null, LinkedInProfileError.fromData(statusCode, data));
  }
}

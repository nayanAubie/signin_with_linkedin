import 'dart:convert';

import 'package:http/http.dart';

import '../../signin_with_linkedin.dart';

/// Manages all the API calls and response handling
final class LinkedInApi {
  LinkedInApi._();

  static final instance = LinkedInApi._();

  final _client = Client();

  late LinkedInConfig config;

  Future<LinkedInAccessToken> getAccessToken({required String code}) async {
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
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return LinkedInAccessToken.fromJson(data);
    }
    throw LinkedInError(
      errorCode: response.statusCode,
      message: data['error'],
      description: data['error_description'],
    );
  }

  Future<LinkedInUser> getUserInfo({
    required String tokenType,
    required String token,
  }) async {
    final response = await _client.get(
      Uri(
        scheme: 'https',
        host: 'api.linkedin.com',
        path: 'v2/userinfo',
      ),
      headers: {'Authorization': '$tokenType $token'},
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return LinkedInUser.fromJson(data);
    }
    throw LinkedInError(
      message: data['message'],
      errorCode: response.statusCode,
    );
  }
}

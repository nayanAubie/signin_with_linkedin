library;

import 'package:flutter/material.dart';

import 'src/core/auth_handler/auth_handler.dart'
    if (dart.library.js_interop) 'src/core/auth_handler/auth_handler_web.dart'
    as auth_code;
import 'src/core/linkedin_api_client.dart';
import 'src/models/models.dart';
import 'src/utils/extensions.dart';

export 'src/models/models.dart';

/// Sign in with LinkedIn handler class.
final class SignInWithLinkedIn {
  final LinkedInConfig config;
  final _apiClient = LinkedInApiClient();

  SignInWithLinkedIn({required this.config});

  /// Get the authorization code from LinkedIn.
  ///
  /// [context] is used to open web view in Android, iOS and macOS.
  /// [appBar] is used to modify app bar in Android, iOS and macOS. (optional).
  Future<(String?, AuthCodeError?)> getAuthorizationCode({
    required BuildContext context,
    PreferredSizeWidget? appBar,
  }) async {
    final redirectUrl = await auth_code.getRedirectUrl(
      context: context,
      authorizationUri: Uri.parse(config.authorizationUrl),
      redirectUri: Uri.parse(config.redirectUrl),
      appBar: appBar,
    );

    if (redirectUrl != null &&
        redirectUrl.getParamValue('state') == config.state) {
      final authCode = redirectUrl.getParamValue('code');
      if (authCode.isNotEmpty) {
        return (authCode, null);
      }
      return (null, AuthCodeError.fromUrl(redirectUrl));
    }
    return (
      null,
      AuthCodeError(
        state: config.state,
        errorCode: 'cancelled',
        errorDescription: 'User cancelled the authentication process',
      ),
    );
  }

  /// Get the access token from LinkedIn. this is a HTTP request and does
  /// not handle 'SocketException' and 'ClientException'.
  /// [authorizationCode] is the value received from [getAuthorizationCode].
  ///
  /// This method should not be used for web because of CORS restrictions.
  /// See the web implementation and example for more details.
  Future<(LinkedInTokenInfo?, LinkedInAuthError?)> getAccessToken({
    required String authorizationCode,
  }) {
    return _apiClient.getAccessToken(config: config, code: authorizationCode);
  }

  /// Get the user profile information from LinkedIn. this is a HTTP request
  /// and does not handle 'SocketException' and 'ClientException'.
  /// [tokenInfo] is the value received from [getAccessToken].
  ///
  /// This method should not be used for web because of CORS restrictions.
  /// See the web implementation and example for more details.
  Future<(LinkedInUser? user, LinkedInProfileError? error)> getUserInfo({
    required LinkedInTokenInfo tokenInfo,
  }) {
    return _apiClient.getUserInfo(
      tokenType: tokenInfo.tokenType,
      token: tokenInfo.accessToken,
    );
  }

  /// Logout from LinkedIn account.
  /// This method opens the logout page in web view / window popup (for web).
  /// [context] is required to open web view.
  /// [appBar] is used to modify app bar in Android, iOS and macOS. (optional).
  Future<bool> logout(
    BuildContext context, {
    PreferredSizeWidget? appBar,
  }) async {
    return auth_code.logout(
      context: context,
      appBar: appBar,
      logoutUri: Uri.parse('https://www.linkedin.com/m/logout/'),
    );
  }
}

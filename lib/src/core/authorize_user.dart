import 'dart:developer';

import '../../signin_with_linkedin.dart';
import 'extensions.dart';

/// Authorize the user and returns either auth token or profile details.
Future<dynamic> authorizeUser(
  String url, {
  OnGetAuthToken? onGetAuthToken,
  OnGetUserProfile? onGetUserProfile,
  OnSignInError? onSignInError,
}) async {
  try {
    final accessTokenData =
        await LinkedInApi.instance.getAccessToken(code: url.authCode);
    if (onGetUserProfile == null) {
      onGetAuthToken?.call(accessTokenData);
      return accessTokenData;
    }
    if (accessTokenData.tokenType != null &&
        accessTokenData.accessToken != null) {
      final userInfo = await LinkedInApi.instance.getUserInfo(
        tokenType: accessTokenData.tokenType!,
        token: accessTokenData.accessToken!,
      );
      onGetUserProfile.call(accessTokenData, userInfo);
      return [accessTokenData, userInfo];
    }
  } catch (e, stackTrace) {
    log(e.toString(), stackTrace: stackTrace);
    final error = e is LinkedInError ? e : LinkedInError(message: e.toString());
    onSignInError?.call(error);
    return error;
  }
}

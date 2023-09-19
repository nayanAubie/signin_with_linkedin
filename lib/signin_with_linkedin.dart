library signin_with_linkedin;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'signin_with_linkedin.dart';

export 'src/core/linkedin_api_handler.dart';
export 'src/models/linked_in_error.dart';
export 'src/models/linkedin_access_token.dart';
export 'src/models/linkedin_config.dart';
export 'src/models/linkedin_locale.dart';
export 'src/models/linkedin_user.dart';
export 'src/ui/linkedin_web_view_page.dart';

final class SignInWithLinkedIn {
  SignInWithLinkedIn._();

  /// Sign in with LinkedIn.
  ///
  /// Provide callback [onGetAuthToken] to get access token related data
  /// Provide callback [onGetUserProfile] if you want to get user profile data
  /// Provide callback [onSignInError] if you want to access error
  ///
  /// Customize the [appBar] for LinkedIn web view page
  static Future<void> signIn(
    BuildContext context, {
    required LinkedInConfig config,
    OnGetAuthToken? onGetAuthToken,
    OnGetUserProfile? onGetUserProfile,
    OnSignInError? onSignInError,
    PreferredSizeWidget? appBar,
  }) async {
    LinkedInApi.instance.config = config;
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LinkedInWebViewPage(
          appBar: appBar,
          getUserProfile: onGetUserProfile != null,
        ),
        fullscreenDialog: true,
      ),
    );
    if (result is LinkedInAccessToken) {
      onGetAuthToken?.call(result);
    } else if (result is LinkedInUser) {
      onGetUserProfile?.call(result);
    } else if (result is LinkedInError) {
      onSignInError?.call(result);
    }
  }

  /// Logout from LinkedIn account
  static Future<bool> logout() async {
    return WebViewCookieManager().clearCookies();
  }
}

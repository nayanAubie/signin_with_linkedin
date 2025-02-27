import 'package:flutter/material.dart';

import '../authorization_web_view.dart';

/// Handles the authorization code flow.
Future<String?> getRedirectUrl({
  required BuildContext context,
  required Uri authorizationUri,
  required Uri redirectUri,
  PreferredSizeWidget? appBar,
}) async {
  final redirectUrl = await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder:
          (context) => AuthorizationWebView(
            initialUri: authorizationUri,
            redirectUri: redirectUri,
            title: 'Sign in with LinkedIn',
            appBar: appBar,
          ),
    ),
  );

  return redirectUrl;
}

/// Handles the logout flow.
Future<bool> logout({
  required BuildContext context,
  required PreferredSizeWidget? appBar,
  required Uri logoutUri,
}) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder:
          (context) => AuthorizationWebView(
            initialUri: logoutUri,
            redirectUri: Uri.parse('https://www.linkedin.com/home'),
            title: 'LinkedIn Logout',
            appBar: appBar,
          ),
    ),
  );
  return true;
}

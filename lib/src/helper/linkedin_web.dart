// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';

import '../../signin_with_linkedin.dart';
import '../core/authorize_user.dart';
import 'linkedin_core.dart';

class LinkedinWeb implements LinkedinCore {
  WindowBase? _popupWin;

  @override
  Future<void> signIn(
    BuildContext context, {
    required LinkedInConfig config,
    OnGetAuthToken? onGetAuthToken,
    OnGetUserProfile? onGetUserProfile,
    OnSignInError? onSignInError,
    PreferredSizeWidget? appBar,
  }) async {
    _popupWin = window.open(
      config.authorizationUrl,
      'LinkedIn Auth',
      'width=800, height=900, scrollbars=yes',
    );

    /// Listen to message send with `postMessage` from html.
    window.onMessage.listen((event) {
      final data = event.data.toString();
      if (data.contains(config.redirectUrl)) {
        if (_popupWin != null) {
          _popupWin?.close();
          _popupWin = null;
        }
        authorizeUser(
          data,
          onGetAuthToken: onGetAuthToken,
          onGetUserProfile: onGetUserProfile,
          onSignInError: onSignInError,
        );
      }
    });
  }

  @override
  Future<bool> logout() async {
    window.open('https://www.linkedin.com/m/logout/', 'new tab');
    return true;
  }
}

LinkedinCore getCoreConfig() => LinkedinWeb();

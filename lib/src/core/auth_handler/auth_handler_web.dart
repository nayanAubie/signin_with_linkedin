import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web/web.dart';

/// Handles the authorization code flow for web.
Future<String?> getRedirectUrl({
  required BuildContext context,
  required Uri authorizationUri,
  required Uri redirectUri,
  PreferredSizeWidget? appBar,
}) async {
  final popup = window.open(
    authorizationUri.toString(),
    'LinkedIn Auth',
    'width=800, height=900, scrollbars=yes',
  );

  StreamSubscription? subscription;
  final completer = Completer<String>();

  subscription = window.onMessage.listen((event) async {
    final data = event.data.toString();
    if (data.contains(redirectUri.toString())) {
      popup?.close();
      completer.complete(data);
      subscription?.cancel();
    }
  });

  return completer.future;
}

/// Handles the logout flow for web.
Future<bool> logout({
  required BuildContext context,
  required PreferredSizeWidget? appBar,
  required Uri logoutUri,
}) {
  window.open(
    logoutUri.toString(),
    'LinkedIn Logout',
    'width=800, height=900, scrollbars=yes',
  );

  return Future.value(true);
}

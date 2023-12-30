import 'package:flutter/material.dart';

import '../../signin_with_linkedin.dart';
import 'choose_linkedin.dart'
    if (dart.library.io) 'linkedin_mobile.dart'
    if (dart.library.html) 'linkedin_web.dart';

class LinkedinCore {
  LinkedinCore();

  factory LinkedinCore.fromConfig() => getCoreConfig();

  Future<void> signIn(
    BuildContext context, {
    required LinkedInConfig config,
    OnGetAuthToken? onGetAuthToken,
    OnGetUserProfile? onGetUserProfile,
    OnSignInError? onSignInError,
    PreferredSizeWidget? appBar,
  }) async =>
      throw UnimplementedError();

  Future<bool> logout() async => throw UnimplementedError();
}

extension StringUtils on String {
  /// Get the auth code from query params of linkedin redirect URL
  String get authCode => split('?').last.split('&').first.split('=').last;
}

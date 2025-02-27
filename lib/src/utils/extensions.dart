extension StringUtils on String {
  /// Get the value of given query parameter from redirect URL.
  String getParamValue(String param) {
    final regex = RegExp('[\\?&]${RegExp.escape(param)}=([^&]+)');
    final match = regex.firstMatch(this);
    return match?.group(1) ?? '';
  }
}

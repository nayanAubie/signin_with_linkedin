import 'package:equatable/equatable.dart';

import '../../utils/extensions.dart';

/// LinkedIn authorization error when redirect URL does not contain code.
final class AuthCodeError extends Equatable {
  /// State of the redirect URL. same value as requested state.
  final String state;

  /// Error code received from redirect URL.
  final String? errorCode;

  /// Error description received from redirect URL.
  final String? errorDescription;

  const AuthCodeError({
    required this.state,
    required this.errorCode,
    required this.errorDescription,
  });

  factory AuthCodeError.fromUrl(String url) {
    return AuthCodeError(
      state: url.getParamValue('state'),
      errorCode: url.getParamValue('error'),
      errorDescription: url.getParamValue('error_description'),
    );
  }

  Map<String, dynamic> toJson() => {
    'state': state,
    'error_code': errorCode,
    'error_description': errorDescription,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [state, errorCode, errorDescription];
}

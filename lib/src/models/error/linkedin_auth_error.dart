import 'package:equatable/equatable.dart';

/// LinkedIn authentication error if access token is not successfully
/// obtained.
class LinkedInAuthError extends Equatable {
  /// HTTP status code.
  final int? statusCode;

  /// Error code.
  final String? error;

  /// Error details.
  final String? errorDescription;

  const LinkedInAuthError({this.statusCode, this.error, this.errorDescription});

  factory LinkedInAuthError.fromData(
    int? statusCode,
    Map<String, dynamic> json,
  ) {
    return LinkedInAuthError(
      statusCode: statusCode,
      error: json['error'],
      errorDescription: json['error_description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'error': error,
    'error_description': errorDescription,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [statusCode, error, errorDescription];
}

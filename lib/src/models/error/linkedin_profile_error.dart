import 'package:equatable/equatable.dart';

/// LinkedIn profile error if user info is not successfully obtained.
class LinkedInProfileError extends Equatable {
  /// HTTP status code.
  final int? statusCode;

  /// Error code.
  final String? code;

  /// Error message.
  final String? message;

  const LinkedInProfileError({this.statusCode, this.code, this.message});

  factory LinkedInProfileError.fromData(
    int? statusCode,
    Map<String, dynamic> json,
  ) {
    return LinkedInProfileError(
      statusCode: statusCode,
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'code': code,
    'message': message,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [statusCode, code, message];
}

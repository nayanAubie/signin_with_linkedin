import 'package:equatable/equatable.dart';

/// Common error class to throw exceptions
class LinkedInError extends Equatable implements Exception {
  final int? errorCode;
  final String? message;
  final String? description;

  const LinkedInError({this.message, this.errorCode, this.description});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [errorCode, message, description];
}

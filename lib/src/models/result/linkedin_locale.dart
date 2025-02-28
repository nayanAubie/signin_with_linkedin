import 'package:equatable/equatable.dart';

/// LinkedIn locale for user.
class LinkedInLocale extends Equatable {
  /// Country code of the user's locale. e.g. 'US'.
  final String? country;

  /// Language code of the user's locale. e.g. 'en'.
  final String? language;

  const LinkedInLocale({this.country, this.language});

  factory LinkedInLocale.fromJson(Map<String, dynamic> json) {
    return LinkedInLocale(
      country: json['country'] as String?,
      language: json['language'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'country': country,
    'language': language,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [country, language];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'linkedin_locale.g.dart';

@JsonSerializable()
class LinkedInLocale extends Equatable {
  final String? country;
  final String? language;

  const LinkedInLocale({this.country, this.language});

  factory LinkedInLocale.fromJson(Map<String, dynamic> json) {
    return _$LinkedInLocaleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LinkedInLocaleToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [country, language];
}

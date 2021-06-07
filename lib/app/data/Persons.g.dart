// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Persons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    id: json['id'] as int?,
    name: json['name'] as String?,
    known_for_department: json['known_for_department'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profile_path: json['profile_path'] as String?,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'name': instance.name,
      'profile_path': instance.profile_path,
      'known_for_department': instance.known_for_department,
    };

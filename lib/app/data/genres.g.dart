// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genres _$GenresFromJson(Map<String, dynamic> json) {
  return Genres(
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'genres': instance.genres,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return Genre(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

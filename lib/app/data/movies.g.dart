// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movies _$MoviesFromJson(Map<String, dynamic> json) {
  return Movies(
    page: json['page'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
    total_pages: json['total_pages'] as int?,
    total_results: json['total_results'] as int?,
  );
}

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
      'results': instance.results,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    backdrop_path: json['backdrop_path'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    id: json['id'] as int?,
    original_title: json['original_title'] as String?,
    overview: json['overview'] as String?,
    poster_path: json['poster_path'] as String?,
    release_date: json['release_date'] as String?,
    title: json['title'] as String?,
    vote_average: (json['vote_average'] as num?)?.toDouble(),
    vote_count: json['vote_count'] as int?,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'backdrop_path': instance.backdrop_path,
      'id': instance.id,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'release_date': instance.release_date,
      'title': instance.title,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };

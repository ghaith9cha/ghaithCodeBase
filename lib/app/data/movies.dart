import 'package:json_annotation/json_annotation.dart';

part 'movies.g.dart';

@JsonSerializable()
class Movies {
  final int? page;
  final int? total_pages;
  final int? total_results;
  final List<Movie>? results;

  Movies({this.page, this.results, this.total_pages, this.total_results});

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}

@JsonSerializable()
class Movie {
  final String? backdrop_path;
  final int? id;
  final String? original_title;
  final String? overview;
  final double? popularity;
  final String? poster_path;
  final String? release_date;
  final String? title;
  final double? vote_average;
  final int? vote_count;

  Movie(
      {this.backdrop_path,
      this.popularity,
      this.id,
      this.original_title,
      this.overview,
      this.poster_path,
      this.release_date,
      this.title,
      this.vote_average,
      this.vote_count});

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}


import 'package:json_annotation/json_annotation.dart';

part 'genres.g.dart';

@JsonSerializable()
class Genres{
  final List<Genre>? genres;

  Genres({this.genres});

  factory Genres.fromJson(Map<String,dynamic> json)=> _$GenresFromJson(json);
  Map<String,dynamic>toJson()=>_$GenresToJson(this);

}

@JsonSerializable()
class Genre{
  final int? id;
  final String? name;
  Genre({this.id,this.name});


  factory Genre.fromJson(Map<String,dynamic> json)=> _$GenreFromJson(json);
  Map<String,dynamic>toJson()=>_$GenreToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'Persons.g.dart';

// @JsonSerializable()
// class Person {
//   final int? page;
//   final List<Results>? results;
//   final int? total_pages;
//   final int? total_results;
//
//   Person({this.page, this.results, this.total_pages, this.total_results});
//
//   factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PersonToJson(this);
// }

@JsonSerializable()
class Person {

  final int? id;
  final double? popularity;
  final String? name;
  final String? profile_path;
  final String? known_for_department;

  Person({
    this.id,
    this.name,
    this.known_for_department,
    this.popularity,
    this.profile_path
});

 factory Person.fromJson(Map<String,dynamic> json)=> _$PersonFromJson(json);

 Map<String,dynamic>toJson()=>_$PersonToJson(this);


}

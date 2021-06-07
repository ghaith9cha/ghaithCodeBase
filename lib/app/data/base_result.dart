import 'package:ghaith_project/app/data/genres.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  int? status_code = null;
  String? status_message = null;
  bool? success = null;
  T? results = null;
  T? genres = null;

  Result({this.results, this.success, this.status_code, this.status_message,this.genres});

  factory Result.fromJson(
    Map<String, dynamic?> json,
    T? Function(Object json) fromJsonT,
  ) {
    if (json['results'] != null) {
      return Result<T>()
        ..status_code = json['status_code'] as int?
        ..status_message = json['status_message'] as String?
        ..success = json['success'] as bool?
        ..results = fromJsonT(json['results']);
    } else {
      return Result<T>()
        ..status_code = json['status_code'] as int?
        ..status_message = json['status_message'] as String?
        ..success = json['success'] as bool?
        ..genres = fromJsonT(json['genres']);
    }
  }
}

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  int? status_code = null;
  String? status_message = null;
  bool? success = null;
  T? results = null;
  T? genres = null;

  BaseResponse(
      {this.results,
      this.success,
      this.status_code,
      this.status_message,
      this.genres});

  factory BaseResponse.fromJson(
    Map<String, dynamic?> json,
    T? Function(Object json) fromJsonT,
  ) {
    if (json['results'] != null) {
      return BaseResponse<T>()
        ..status_code = json['status_code'] as int?
        ..status_message = json['status_message'] as String?
        ..success = json['success'] as bool?
        ..results = fromJsonT(json['results']);
    } else {
      return BaseResponse<T>()
        ..status_code = json['status_code'] as int?
        ..status_message = json['status_message'] as String?
        ..success = json['success'] as bool?
        ..genres = fromJsonT(json['genres']);
    }
  }
}

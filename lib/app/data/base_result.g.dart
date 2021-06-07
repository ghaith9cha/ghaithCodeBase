// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result<T> _$ResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Result<T>(
    results: _$nullableGenericFromJson(json['results'], fromJsonT),
    success: json['success'] as bool?,
    status_code: json['status_code'] as int?,
    status_message: json['status_message'] as String?,
    genres: _$nullableGenericFromJson(json['genres'], fromJsonT),
  );
}

Map<String, dynamic> _$ResultToJson<T>(
  Result<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.status_code,
      'status_message': instance.status_message,
      'success': instance.success,
      'results': _$nullableGenericToJson(instance.results, toJsonT),
      'genres': _$nullableGenericToJson(instance.genres, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseResponse<T>(
    results: _$nullableGenericFromJson(json['results'], fromJsonT),
    success: json['success'] as bool?,
    status_code: json['status_code'] as int?,
    status_message: json['status_message'] as String?,
    genres: _$nullableGenericFromJson(json['genres'], fromJsonT),
  );
}

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.status_code,
      'status_message': instance.status_message,
      'success': instance.success,
      'results': _$nullableGenericToJson(instance.results, toJsonT),
      'genres': _$nullableGenericToJson(instance.genres, toJsonT),
    };

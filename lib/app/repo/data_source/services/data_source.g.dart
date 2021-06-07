// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GhaithServices implements GhaithServices {
  _GhaithServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.themoviedb.org/3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse<List<Person>>> getActorEntity(api_key, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': api_key,
      r'language': language
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<Person>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'trending/person/week',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<List<Person>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<Person>((i) => Person.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<BaseResponse<List<Movie?>?>?> getMovieByGenre(
      api_key, language, withGenre) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': api_key,
      r'language': language,
      r'with_genres': withGenre
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<Movie>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'discover/movie',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : BaseResponse<List<Movie>>.fromJson(
            _result.data!,
            (json) => (json as List<dynamic>)
                .map<Movie>((i) => Movie.fromJson(i as Map<String, dynamic>))
                .toList());
    return value;
  }

  @override
  Future<BaseResponse<List<Genre?>?>?> getGenreList(api_key, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': api_key,
      r'language': language
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<Genre>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'genre/movie/list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : BaseResponse<List<Genre>>.fromJson(
            _result.data!,
            (json) => (json as List<dynamic>)
                .map<Genre>((i) => Genre.fromJson(i as Map<String, dynamic>))
                .toList());
    return value;
  }

  @override
  Future<BaseResponse<List<Movie?>?>?> getTopMovies(
      api_key, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': api_key,
      r'language': language,
      r'page': page
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<Movie>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'movie/top_rated',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : BaseResponse<List<Movie>>.fromJson(
            _result.data!,
            (json) => (json as List<dynamic>)
                .map<Movie>((i) => Movie.fromJson(i as Map<String, dynamic>))
                .toList());
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

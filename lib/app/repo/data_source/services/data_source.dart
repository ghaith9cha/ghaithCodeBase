import 'package:ghaith_project/app/data/Persons.dart';
import 'package:ghaith_project/app/data/base_result.dart';
import 'package:ghaith_project/app/data/genres.dart';
import 'package:ghaith_project/app/data/movies.dart';
import 'package:ghaith_project/app/repo/data_source/api_constant.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'data_source.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class GhaithServices {
  factory GhaithServices(Dio dio, {String baseUrl}) = _GhaithServices;

  @GET(MoviesActorEndPoint)
  Future<BaseResponse<List<Person>>> getActorEntity(
      @Query("api_key") String api_key, @Query("language") String language);

  @GET(MoviesByGenreEndPoint)
  Future<BaseResponse<List<Movie?>?>?> getMovieByGenre(
      @Query("api_key") String api_key,
      @Query("language") String language,
      @Query("with_genres") int? withGenre);

  @GET(GenreListEndPoint)
  Future<BaseResponse<List<Genre?>?>?> getGenreList(
      @Query("api_key") String api_key, @Query("language") String language);

  @GET(TopMovies)
  Future<BaseResponse<List<Movie?>?>?> getTopMovies(
      @Query("api_key") String api_key, @Query("language") String language, @Query("page") int? page);


}

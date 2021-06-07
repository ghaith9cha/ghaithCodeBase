import 'package:ghaith_project/app/data/Persons.dart';
import 'package:ghaith_project/app/data/base_result.dart';
import 'package:ghaith_project/app/data/genres.dart';
import 'package:ghaith_project/app/data/movies.dart';
import 'package:ghaith_project/app/repo/data_source/remote_data_source.dart';
import 'package:ghaith_project/app/utility/extintion.dart';

class AppRepository {
  final dataSource = RemoteDataSource();

  Future<Result<List<Movie?>?>?> getMoviesByGenre(
      String api_key, String language, int? withGenre) async {
    return  await repositoryHelper(
        request: () => dataSource.ghaithService
            .getMovieByGenre(api_key, language, withGenre));
  }

  Future<Result<List<Genre?>?>?> getGenre(String api_key, String language) async {
    return await repositoryHelper(
        request: () =>
            dataSource.ghaithService.getGenreList(api_key, language));
  }

  Future<Result<List<Person?>?>?> getPersons(String api_key,String language) async {
    return await repositoryHelper(request: ()=>
    dataSource.ghaithService.getActorEntity(api_key, language));
  }

  Future<Result<List<Movie?>?>?> getTopMovies(String api_key,String language, int? page) async{
    return await repositoryHelper(request: ()=>
    dataSource.ghaithService.getTopMovies(api_key,language,page));
  }
}

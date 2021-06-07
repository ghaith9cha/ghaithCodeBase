import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/data/Persons.dart';
import 'package:ghaith_project/app/data/genres.dart';
import 'package:ghaith_project/app/data/movies.dart';
import 'package:ghaith_project/app/repo/data_source/api_constant.dart';
import 'package:ghaith_project/app/utility/network_conectivity.dart';
import 'package:ghaith_project/main/main_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final MainController mainController = Get.find();
  final NetworkConnectivity networkConnectivity = Get.find();
  final RxList<Movie?>? movieByGenre = RxList<Movie>();
  final movieGenreMap = Map<int, List<Movie?>?>();
  final RxList<Person?>? personsList = RxList<Person>();
  var currentPage = 36;
  List<Movie?>? topMovies = List<Movie>.empty(growable: true);

  var page = 1;
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = 200.obs;
  final topMoviesState = 0.obs;
  final movieGenreState = 0.obs;
  final genresState = 0.obs;
  final isTopMovieLoadedState = false.obs;
  final personsState = 0.obs;

  final RxList<Genre?>? genres = RxList<Genre>();

  @override
  void onInit() async {
    super.onInit();

    paginateTask();
    await mainController.repo
        .getPersons("d81588933147f7ace69e1c44a5d3a0ad", "en-US")
        .then((value) => {
              if (value?.status_code == 200 && value?.results != null)
                {
                  personsList!.value = value!.results!,
                  print("THis is persons $value"),
                  personsState.value = 200
                }
              else if (value?.status_code == 200)
                {
                  personsState.value = 300,
                }
              else
                {personsState.value = 500}
            });

    await mainController.repo
        .getGenre("d81588933147f7ace69e1c44a5d3a0ad", "en-US")
        .then((value) => {
              print("HEHEHEEHEH ${value?.genres}"),
              if (value?.status_code == 200 && value?.genres != null)
                {
                  genres?.value = value!.genres!,
                  print(value?.results),
                  genresState.value = 200
                }
              else if (value?.status_code == 200)
                {
                  genresState.value = 300,
                  //TODO show no content
                }
              else if (value?.status_code == 500)
                {
                  genresState.value = 500
                  //TODO show snackbar
                }
            });

    await mainController.repo
        .getMoviesByGenre("d81588933147f7ace69e1c44a5d3a0ad", "en-US", 36)
        .then((value) => {
              if (value?.status_code == 200 && value?.results != null)
                {
                  movieGenreMap[36] = value?.results,
                  movieByGenre!.value = value!.results!,
                  print(value.results),
                  movieGenreState.value = 200,
                }
              else if (value?.status_code == 200)
                {
                  movieGenreState.value = 300,
                  //TODO show no content
                }
              else if (value?.status_code == 500)
                {
                  movieGenreState.value = 500
                  //TODO show snackbar
                }
            });

    await mainController.repo
        .getTopMovies("d81588933147f7ace69e1c44a5d3a0ad", "en-US", 1)
        .then((value) => {
              if (value?.status_code == 200 && value?.results != null)
                {
                  page++,
                  isTopMovieLoadedState.value = true,
                  topMovies!.addAll(value!.results!),
                  print(value.results),
                  topMoviesState.value = 200,
                }
              else if (value?.status_code == 200)
                {
                  page++,
                  topMoviesState.value = 300,
                  //TODO show no content
                }
              else if (value?.status_code == 500)
                {
                  topMoviesState.value = 500
                  //TODO show snackbar
                }
            });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  void getMovieByGenre(int index) async {
    if (movieGenreMap[index] != null) {
      currentPage = index;
    return;
    } else {
      movieGenreState.value = 0;

      await mainController.repo
          .getMoviesByGenre("d81588933147f7ace69e1c44a5d3a0ad", "en-US", index)
          .then((value) => {
                currentPage = index,
                if (value?.status_code == 200 && value?.results != null)
                  {
                    movieGenreMap[index] = value!.results!,
                    movieByGenre!.value = value!.results!,
                    print(value.results),
                    movieGenreState.value = 200,
                  }
                else if (value?.status_code == 200)
                  {
                    movieGenreState.value = 300,
                    //TODO show no content
                  }
                else if (value?.status_code == 500)
                  {
                    movieGenreState.value = 500
                    //TODO show snackbar
                  }
              });
    }
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("Reached end");
        getMoreTask(page);
      }
    });
  }

  getMoreTask(int page) async {
    topMoviesState.value = 0;
    isMoreDataAvailable.value = 0;
    await mainController.repo
        .getTopMovies("d81588933147f7ace69e1c44a5d3a0ad", "en-US", page)
        .then((value) => {
              if (value?.status_code == 200 && value?.results != null)
                {
                  isMoreDataAvailable.value = 200,
                  topMovies!.addAll(value!.results!),
                  print(value.results),
                  page++,
                  topMoviesState.value = 200,
                }
              else if (value?.status_code == 200)
                {
                  isMoreDataAvailable.value = 300,
                  page++,
                  topMoviesState.value = 300,
                  //TODO show no content
                }
              else if (value?.status_code == 500)
                {
                  isMoreDataAvailable.value = 500,
                  topMoviesState.value = 500
                  //TODO show snackbar
                }
              else
                {
                  isMoreDataAvailable.value = 0,
                }
            });
  }
}

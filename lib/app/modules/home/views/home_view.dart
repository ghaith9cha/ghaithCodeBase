import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/data/genres.dart';
import 'package:ghaith_project/app/utility/main_drawer.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // if(controller.mainController.prefs.getString("locale")==null){
    //   controller.mainController.prefs
    //       .setString("language_code", "en");
    //   controller.mainController.prefs
    //       .setString("country_code", "US");
    // }
    return Scaffold(
      drawer: MainDrawer(),
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text('Movie App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.personsState == 200) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .24,
                  child: ListView.builder(
                      itemCount: controller.personsList?.take(5).length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 5, 20),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200${controller.personsList![index]!.profile_path}",
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  controller.personsList![index]!.name
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(2),
                                child: Text(
                                  controller
                                      .personsList![index]!.known_for_department
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else if (controller.personsState == 300) {
                return Text("no Content");
              } else if (controller.personsState == 500) {
                return Text(
                  "Show Error SnackBar",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
            Obx(() {
              if (controller.genresState == 200) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .48,
                  child: DefaultTabController(
                    length: controller.genres!.length,
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (int index) {
                            controller.getMovieByGenre(
                                controller.genres![index]!.id!);
                          },
                          isScrollable: true,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.red,
                          tabs: (controller.genres as List<Genre>)
                              .map((Genre genre) => Text(genre.name.toString()))
                              .toList(),
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        Obx(() {
                          if (controller.movieGenreState == 200) {
                            return Expanded(
                                child: TabBarView(
                              children: controller.genres!
                                  .map((e) => Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .5,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .movieGenreMap[
                                                  controller.currentPage]!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed("/movie",
                                                        arguments: controller.movieGenreMap[controller.currentPage]![index]!);
                                                  },
                                                  child: Hero(
                                                    flightShuttleBuilder: (
                                                      BuildContext
                                                          flightContext,
                                                      Animation<double>
                                                          animation,
                                                      HeroFlightDirection
                                                          flightDirection,
                                                      BuildContext
                                                          fromHeroContext,
                                                      BuildContext
                                                          toHeroContext,
                                                    ) {
                                                      return RefreshProgressIndicator();
                                                    },
                                                    tag: controller
                                                        .movieGenreMap[
                                                            controller
                                                                .currentPage]![
                                                            index]!
                                                        .id!,
                                                    child: Image(
                                                        image: NetworkImage(
                                                            "https://image.tmdb.org/t/p/w200${controller.movieGenreMap[controller.currentPage]![index]!.poster_path}")),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ));
                          } else if (controller.movieGenreState == 300) {
                            return Text("NO Content");
                          } else if (controller.movieGenreState == 500) {
                            return Text(
                              "Put your error here",
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                      ],
                    ),
                  ),
                );
              } else if (controller.genresState == 300) {
                return Text(
                  "No Content",
                  style: TextStyle(fontSize: 25, color: Colors.red),
                );
              } else if (controller.genresState == 500) {
                return Text(
                  "Put your error here",
                  style: TextStyle(fontSize: 25, color: Colors.red),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
            Obx(() {
              if (controller.isTopMovieLoadedState == true) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .44,
                  child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.topMovies?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.topMovies!.length - 1 &&
                            controller.isMoreDataAvailable.value == 0) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (index == controller.topMovies!.length - 1 &&
                            controller.isMoreDataAvailable.value == 500) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.getMoreTask(controller.page);
                                  CircularProgressIndicator();
                                },
                                child: Text(
                                  "Try Again?",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ),
                            ),
                          );
                        } else if (index == controller.topMovies!.length - 1 &&
                            controller.isMoreDataAvailable.value == 300) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text("No more Content"),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 5, 20),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed("/movie",
                                      arguments: controller.topMovies![index]);
                                },
                                child: Hero(
                                  flightShuttleBuilder: (
                                    BuildContext flightContext,
                                    Animation<double> animation,
                                    HeroFlightDirection flightDirection,
                                    BuildContext fromHeroContext,
                                    BuildContext toHeroContext,
                                  ) {
                                    return RefreshProgressIndicator();
                                  },
                                  tag: controller.topMovies![index]!.id
                                      .toString(),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200${controller.topMovies![index]!.poster_path}",
                                    ),
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  controller.topMovies![index]!.title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else if (controller.topMoviesState == 300) {
                return Text("no Content");
              } else if (controller.topMoviesState == 500) {
                return Text(
                  "Shwo Error SnackBar",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                );
              } else {
                return Center(
                  child: Text("HELOO"),
                );
              }
            }),
            Obx(() {
              if (controller.movieGenreState.value == 200) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: CarouselSlider(
                    items: generateSlider(),
                    options: CarouselOptions(
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height * 0.5,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height),
                  ),
                );
              } else {
                return Text("NO CONENT");
              }
            }),
            Column(
              children: [
                Text(
                  "Ghaith".tr,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "School".tr,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "University".tr,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.mainController.prefs
                        .setString("locale", "ar_EG");

                    Get.updateLocale(Locale("ar", "EG"));
                    controller.mainController.prefs
                        .setString("language_code", "ar");
                    controller.mainController.prefs
                        .setString("country_code", "EG");
                  },
                  child: Text("Arabic"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.mainController.prefs
                        .setString("locale", "en_US");
                    controller.mainController.prefs
                        .setString("language_code", "en");
                    controller.mainController.prefs
                        .setString("country_code", "US");

                    Get.updateLocale(Locale("en", "US"));
                  },
                  child: Text("English"),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.signInWithFacebook();
                  },
                  child: Text("Login with Facebook"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                  child: Text("Login with Google"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/map");
                    },
                    child: Text("Go to map screen")),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/downloader");
                    },
                    child: Text("Go to Download Screen")),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/camera");
                    },
                    child: Text("Go to Camera")),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> generateSlider() {
    return controller.movieGenreMap[36]!.map((item) {
      return Container(
        child: Container(
          margin: EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              Get.toNamed("/movie", arguments: item);
            },
            child: Hero(
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return RefreshProgressIndicator();
              },
              tag: item!.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/w200${item.poster_path}",
                  fit: BoxFit.fitHeight,
                  width: Get.width,
                  height: Get.height,
                  placeholder: (context, url) => Container(
                    color: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

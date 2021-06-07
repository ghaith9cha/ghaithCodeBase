import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ghaith_project/app/repo/data_source/services/data_source.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class RemoteDataSource {
  late final Dio dio;

  late final GhaithServices ghaithService;

  RemoteDataSource() {
    //Todo Creating Necessary Information For the Client From Baseurl,Headers,Log,SendTimeout,Receive Timeout
    //Todo Best Information To use are BaseOptions , InterceptorsWrapper

    dio = Dio();
    log("Log Created");
    dio.options = BaseOptions(
      headers: {"Content-Type": "application/json"},
      baseUrl: "https://api.themoviedb.org/3/",
      // sendTimeout: 5000,
      // connectTimeout: 30,
    );
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    log("Went to Log Interceptor");

    ghaithService = GhaithServices(dio,baseUrl: "https://api.themoviedb.org/3/");
  }
}

//TODO fake Interceptor using Dio Adapter
//Add json Response
/*
   dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.path == "one") {
          return handler
              .resolve(Response(requestOptions: options, data: response));
        } else {
          handler.next(options);
        }
      },
    ));
 */

//Todo fake Repo Using Http Mock Adapter
/*
   // dio.httpClientAdapter=dioAdapter;
    // dioAdapter
    //   ..onGet(
    //     "one",
    //         (request) => request.reply(200, {'message': 'Successfully mocked GET!'}),
    //   );

    //Making Fake Repo Using Dio Adapter


 */

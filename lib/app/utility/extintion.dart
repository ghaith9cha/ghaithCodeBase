import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ghaith_project/app/data/base_result.dart';
import 'package:ghaith_project/app/data/movies.dart';

Future<Result<T?>?> repositoryHelper<T>(
    {required Future<BaseResponse<T?>?> Function() request}) async {
  try {
    final response = await request();

    // check if server response is successful
    if (response?.success == null) {
      if (response?.results != null) {
        log("FROM HELPER ${response?.results}");
        // TODO: separate state ID and api code.
        return Result(
            status_code: 200,
            status_message: response?.status_message,
            results: response?.results);
      } else if (response?.genres != null) {
        return Result(
            status_code: 200,
            status_message: response?.status_message,
            genres: response?.genres);
      } else {
        return Result(status_code: 200);
      }
    } else {
      return Result(status_code: 500, status_message: response?.status_message);
    }
  } catch (exception, stacktrace) {
    log("Exception occurred in : $exception And The Stacktrace is $stacktrace");
    return Result(status_code: 500);
  }
}

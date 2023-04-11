import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newmovieapp/api_exception/api_exception.dart';
import '../api.dart';
import '../model/movie.dart';
import '../providers/client_provider.dart';


final movieService = Provider((ref) => MovieService(ref.watch(clientProvider)));

class MovieService {
  final Dio dio;
  MovieService(this.dio);

  Future<Either<String, List<Movie>>> getData(
      {required String apiPath, required int page}) async {
    try {
      final Response = await dio
          .get(apiPath, queryParameters: {'api_key': Api.apiKey, 'page': page});


      if (apiPath == Api.popularMovie){
        final res = await dio.get(apiPath,
            queryParameters: {'api_key': Api.apiKey,
              'page': page});

        final box = Hive.box<String>('movie');
        box.put('popular', jsonEncode(Response.data['results']));

      }



      final extractData = (Response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      return Right(extractData);
    } on DioError catch (err, stack) {
      return Left(err.toString());
    }
  }

  Future<Either<String, List<Movie>>> searchMovie(String q) async {
    try {
      final Response = await dio.get(Api.searchMovie,
          queryParameters: {
        'api_key': Api.apiKey,
        'page': 1,
        'query': q
          }
          );

      if((Response.data['results'] as List).isEmpty){
        return Left('No movies found try another keyword');
      }else{
        final extractData = (Response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return Right(extractData);
      }


    } on DioError catch (err, stack) {
      return Left(DioException().getDioError(err));
    }
  }


}

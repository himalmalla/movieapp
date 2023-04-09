import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newmovieapp/providers/client_provider.dart';
import '../api.dart';


final videoProvider = FutureProvider.family((ref, int id) => VideoProvider(ref.watch(clientProvider),id).getVideoId());

class VideoProvider {
   final Dio _dio;
   final int id;

   VideoProvider(this._dio, this.id);

   Future <String> getVideoId() async{
     try{
       final response = await _dio.get('/movie/$id/videos', queryParameters: {
         'api_key' : Api.apiKey
       });
       return response.data['results'] [0]['key'];
     }
     on DioError catch(err){
       return err.toString();
     }
   }

}
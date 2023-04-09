import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newmovieapp/providers/client_provider.dart';
import '../api.dart';

final imageProvider = FutureProvider.family((ref, int id) => ImageProvider(ref.watch(clientProvider), id).getImageId());

class ImageProvider {
  final Dio _dio;
  final int id;
  ImageProvider(this._dio, this.id);

  Future <String> getImageId() async{
    try{
      final response = await _dio.get('/movie/$id/images', queryParameters: {
        'api_key': Api.apiKey
      });
      return response.data['results'][0]['key'];
    } on DioError catch (err){
      return err.toString();
    }
  }
}
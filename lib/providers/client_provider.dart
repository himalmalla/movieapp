import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';

final clientProvider = Provider((ref) {
  final options = BaseOptions(
    baseUrl: Api.baseUrl,
  );
  return Dio(options);
});

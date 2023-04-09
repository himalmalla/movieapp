import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movie_state.dart';
import '../services/movie_service.dart';

final movieProvider =
    StateNotifierProvider.family<MovieProvider, MovieState, String>(
        (ref, String api) =>
            MovieProvider(MovieState.empty(), ref.watch(movieService), api));

class MovieProvider extends StateNotifier<MovieState> {
  final MovieService service;
  final String apiPath;
  MovieProvider(super.state, this.service, this.apiPath) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(
        errMessage: '',
        isSuccess: false,
        isError: false,
        // movies: [],
        isLoad: state.isLoadMore ? false: true);

    final response = await service.getData(apiPath: apiPath, page: state.page);
    response.fold((l) {
      state = state.copyWith(
          errMessage: l,
          isSuccess: false,
          isError: true,
          movies: [],
          isLoad: false);
    }, (r) {
      state = state.copyWith(
          errMessage: '',
          isSuccess: true,
          isError: false,
          movies: [...state.movies, ...r],
          isLoad: false);
    });
  }

  void loadMore() async {
    state = state.copyWith(isLoadMore: true, page: state.page + 1);
    getData();
  }
}

import 'movie.dart';

class MovieState {
  final bool isError;
  final bool isSuccess;
  final String errMessage;
  final bool isLoad;
  final List<Movie> movies;
  final int page;
  final bool isLoadMore;

  MovieState(
      {required this.errMessage,
        required this.isError,
        required this.isSuccess,
        required this.isLoad,
        required this.movies,
        required this.page,
        required this.isLoadMore
      });

  MovieState copyWith(
      {bool? isError,
        bool? isSuccess,
        String? errMessage,
        bool? isLoad,
        List<Movie>? movies,
        int? page,
        bool? isLoadMore
      }) {
    return MovieState(
        errMessage: errMessage ?? this.errMessage,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoad: isLoad ?? this.isLoad,
        movies: movies ?? this.movies,
        page: page ?? this.page,
        isLoadMore: isLoadMore ?? this.isLoadMore
    );
  }

  factory MovieState.empty() {
    return MovieState(
        errMessage: '',
        isError: false,
        isSuccess: false,
        isLoad: false,
        movies: [],
        page: 1,
        isLoadMore: false
    );
  }
}

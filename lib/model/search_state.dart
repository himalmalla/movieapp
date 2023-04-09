import 'movie.dart';

class SearchState {
  final bool isError;
  final bool isSuccess;
  final String errMessage;
  final bool isLoad;
  final List<Movie> movies;
  final int page;

  SearchState(
      {required this.errMessage,
        required this.isError,
        required this.isSuccess,
        required this.isLoad,
        required this.movies,
        required this.page,
      });

  SearchState copyWith(
      {bool? isError,
        bool? isSuccess,
        String? errMessage,
        bool? isLoad,
        List<Movie>? movies,
        int? page,
      }) {
    return SearchState(
        errMessage: errMessage ?? this.errMessage,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoad: isLoad ?? this.isLoad,
        movies: movies ?? this.movies,
        page: page ?? this.page,
    );
  }

  factory SearchState.empty() {
    return SearchState(
        errMessage: '',
        isError: false,
        isSuccess: false,
        isLoad: false,
        movies: [],
        page: 1,
    );
  }
}

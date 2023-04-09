class Movie {
  final String title;
  final String backdrop_path;
  final int id;
  final String poster_path;
  final String overview;
  final String vote_average;

  Movie(
      {required this.title,
        required this.backdrop_path,
        required this.id,
        required this.overview,
        required this.poster_path,
        required this.vote_average});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'] ?? '',
        backdrop_path: json['backdrop_path'] ?? '',
        id: json['id'] ?? '0',
        overview: json['overview'],
        poster_path:
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['poster_path']}',
        vote_average: '${json['vote_average']}');
  }
  @override
  String toString() {
    return 'Movie('
        'title: $title'
        'vote_average: $vote_average'
        ')';
  }
}

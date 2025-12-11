import '../models/movie_model.dart';

abstract class SearchTabDataSource {
  /// Returns list of movies (may be empty)
  Future<List<Movie>> fetchMovies({String? query});
}

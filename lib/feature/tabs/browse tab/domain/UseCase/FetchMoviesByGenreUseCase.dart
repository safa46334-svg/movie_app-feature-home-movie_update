import '../../data/repository/Browse Repository.dart';

class FetchMoviesByGenreUseCase {
  final BrowseRepository repository;

  FetchMoviesByGenreUseCase({required this.repository});

  Future<List<Map<String, dynamic>>> call(String genre) {
    return repository.fetchMoviesByGenre(genre);
  }
}

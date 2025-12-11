import '../data scource/Browse DataSource.dart';

abstract class BrowseRepository {
  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(String genre);
}

class BrowseRepositoryImpl implements BrowseRepository {
  final BrowseDataSource dataSource;

  BrowseRepositoryImpl({required this.dataSource});

  @override
  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(String genre) {
    return dataSource.fetchMoviesByGenre(genre);
  }
}

//
// import '../models/movie_model.dart';
//
// abstract class SearchRepository {
//   Future<List<Movie>> fetchMovies({required String query});
// }
//
//


import '../models/movie_model.dart';
import '../data scourcs/search_tab_data_source.dart';

abstract class SearchRepository {
  Future<List<Movie>> fetchMovies({required String query});
}

class SearchTabRepositoryImpl implements SearchRepository {
  final SearchTabDataSource dataSource;

  SearchTabRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> fetchMovies({required String query}) async {
    return await dataSource.fetchMovies(query: query);
  }
}

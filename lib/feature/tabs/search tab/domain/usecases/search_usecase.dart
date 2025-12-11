
// import '../../data/models/movie_model.dart';
// import '../../data/repository_impl/search_tab_repository..dart';
//
// class SearchUsecase {
//   final SearchRepository repository;
//
//   SearchUsecase({required this.repository});
//
//   Future<List<Movie>> call(String query) {
//     return repository.fetchMovies(query: query);
//   }
// }
//
//


import '../../data/models/movie_model.dart';
import '../../data/repository_impl/search_tab_repository..dart';
import '../../data/repository_impl/search_tab_repository_impl.dart';

class SearchUsecase {
  final SearchRepository repository;

  SearchUsecase({required this.repository});

  Future<List<Movie>> call(String query) {
    return repository.fetchMovies(query: query);
  }
}

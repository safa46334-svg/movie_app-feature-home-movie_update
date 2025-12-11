// import '../../data/models/movie_model.dart';
//
// abstract class SearchTabState {}
//
// class SearchTabInitial extends SearchTabState {}
//
// class SearchTabLoading extends SearchTabState {}
//
// class SearchTabLoaded extends SearchTabState {
//   final List<Movie> movies;
//   SearchTabLoaded(this.movies);
// }
//
// class SearchTabError extends SearchTabState {
//   final String message;
//   SearchTabError(this.message);
// }
import '../../data/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> movies;
  SearchLoaded(this.movies);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

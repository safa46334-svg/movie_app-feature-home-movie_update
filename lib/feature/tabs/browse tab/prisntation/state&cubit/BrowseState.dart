import 'package:bloc/bloc.dart';

import '../../domain/UseCase/FetchMoviesByGenreUseCase.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}
class BrowseLoading extends BrowseState {}
class BrowseLoaded extends BrowseState {
  final List<Map<String, dynamic>> movies;
  BrowseLoaded(this.movies);
}
class BrowseEmpty extends BrowseState {}
class BrowseError extends BrowseState {
  final String message;
  BrowseError(this.message);
}

class BrowseCubit extends Cubit<BrowseState> {
  final FetchMoviesByGenreUseCase useCase;

  BrowseCubit({required this.useCase}) : super(BrowseInitial());

  Future<void> fetchMovies(String genre) async {
    emit(BrowseLoading());
    try {
      final movies = await useCase.call(genre);
      if (movies.isEmpty) {
        emit(BrowseEmpty());
      } else {
        emit(BrowseLoaded(movies));
      }
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }
}

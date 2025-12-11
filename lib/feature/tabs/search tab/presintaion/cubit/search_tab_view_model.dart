//
// import 'package:bloc/bloc.dart';
// import 'package:movie_app/feature/tabs/search%20tab/presintaion/cubit/search_tab_states.dart';
// import '../../data/models/movie_model.dart';
// import '../../domain/usecases/search_usecase.dart';
//
// class SearchCubit extends Cubit<SearchState> {
//   final SearchUsecase searchUsecase;
//
//   SearchCubit({required this.searchUsecase}) : super(SearchInitial());
//
//   Future<void> search(String query) async {
//     if (query.trim().isEmpty) {
//       emit(SearchEmpty());
//       return;
//     }
//
//     emit(SearchLoading());
//     try {
//       final movies = await searchUsecase.call(query);
//       if (movies.isEmpty) {
//         emit(SearchEmpty());
//       } else {
//         emit(SearchLoaded(movies));
//       }
//     } catch (e) {
//       emit(SearchError(e.toString()));
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import '../cubit/search_tab_states.dart';
import '../../domain/usecases/search_usecase.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUsecase searchUsecase;

  SearchCubit({required this.searchUsecase}) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchEmpty());
      return;
    }

    emit(SearchLoading());
    try {
      final movies = await searchUsecase.call(query);
      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

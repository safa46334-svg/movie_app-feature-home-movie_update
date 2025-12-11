// // profile_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/feature/tabs/profile%20tab/presentation/cubit/profile_state.dart';
//
// import '../../data/models/history_model.dart';
// import '../../data/models/watchlist_model.dart';
// import '../../domain/usecases/add_to_history_usecase.dart';
// import '../../domain/usecases/add_to_watchlist_usecase.dart';
// import '../../domain/usecases/get_history_usecase.dart';
// import '../../domain/usecases/get_watchlist_usecase.dart';
//
// class ProfileCubit extends Cubit<ProfileState> {
//   final GetWatchlistUsecase getWatchlist;
//   final AddToWatchlistUsecase addWatch;
//   final GetHistoryUsecase getHistory;
//   final AddToHistoryUsecase addHistory;
//
//   ProfileCubit({
//     required this.getWatchlist,
//     required this.addWatch,
//     required this.getHistory,
//     required this.addHistory,
//   }) : super(ProfileInitial());
//
//   loadProfile() {
//     emit(ProfileLoaded(getWatchlist(), getHistory()));
//   }
//
//   addToWatchlist(WatchlistItem item) {
//     addWatch(item);
//     loadProfile();
//   }
//
//   addToHistory(HistoryItem item) {
//     addHistory(item);
//     loadProfile();
//   }
// }
// lib/feature/profile/presentation/cubit/profile_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_to_history_usecase.dart';
import '../../domain/usecases/add_to_watchlist_usecase.dart';
import '../../domain/usecases/get_history_usecase.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetWatchlistUsecase getWatchlist;
  final GetHistoryUsecase getHistory;
  final AddToWatchlistUsecase addWatchlist;
  final AddToHistoryUsecase addHistory;

  ProfileCubit({
    required this.getWatchlist,
    required this.getHistory,
    required this.addWatchlist,
    required this.addHistory,
  }) : super(ProfileLoading()) {
    loadProfileData();
  }

  Future loadProfileData() async {
    try {
      final watch = await getWatchlist();
      final hist = await getHistory();
      emit(ProfileLoaded(watchlist: watch, history: hist));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future addToWatchlist(newMovie) async {
    await addWatchlist(newMovie);
    loadProfileData();
  }

  Future addToHistory(newMovie) async {
    await addHistory(newMovie);
    loadProfileData();
  }
}

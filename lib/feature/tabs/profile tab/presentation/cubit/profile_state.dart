// // profile_state.dart
// import '../../data/models/history_model.dart';
// import '../../data/models/watchlist_model.dart';
//
// abstract class ProfileState {}
//
// class ProfileInitial extends ProfileState {}
// class ProfileLoaded extends ProfileState {
//   final List<WatchlistItem> watchlist;
//   final List<HistoryItem> history;
//   ProfileLoaded(this.watchlist, this.history);
// }
// lib/feature/profile/presentation/cubit/profile_state.dart

import '../../data/models/watchlist_model.dart';
import '../../data/models/history_model.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<WatchlistItem> watchlist;
  final List<HistoryItem> history;
  ProfileLoaded({required this.watchlist, required this.history});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

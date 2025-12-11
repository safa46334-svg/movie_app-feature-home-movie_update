
import 'package:movie_app/feature/tabs/profile%20tab/data/repository_impl/profile_repository.dart';

import '../data_source/profile_remote_source.dart';
import '../models/watchlist_model.dart';
import '../models/history_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteSource remote;

  ProfileRepositoryImpl({required this.remote});

  @override
  Future<List<WatchlistItem>> getWatchlist() => remote.getWatchlist();

  @override
  Future<List<HistoryItem>> getHistory() => remote.getHistory();

  @override
  Future<void> addWatchlist(WatchlistItem movie) => remote.addToWatchlist(movie);

  @override
  Future<void> addHistory(HistoryItem movie) => remote.addToHistory(movie);
}

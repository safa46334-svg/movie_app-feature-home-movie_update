// lib/feature/profile/domain/repository/profile_repository.dart

import '../../data/models/watchlist_model.dart';
import '../../data/models/history_model.dart';

abstract class ProfileRepository {
  Future<List<WatchlistItem>> getWatchlist();
  Future<List<HistoryItem>> getHistory();

  Future<void> addWatchlist(WatchlistItem item);
  Future<void> addHistory(HistoryItem item);
}

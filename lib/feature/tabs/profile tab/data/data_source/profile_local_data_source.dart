// lib/feature/profile_tab/data/data_source/profile_local_data_source.dart
import '../models/history_model.dart';
import '../models/watchlist_model.dart';

class ProfileLocalDataSource {
  List<WatchlistItem> watchlist = [];
  List<HistoryItem> history = [];

  List<WatchlistItem> getWatchlist() => watchlist;
  List<HistoryItem> getHistory() => history;

  void addToWatchlist(WatchlistItem item) => watchlist.add(item);
  void addToHistory(HistoryItem item) => history.add(item);
}

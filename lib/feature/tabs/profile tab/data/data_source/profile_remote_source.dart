// lib/feature/profile/data/datasource/profile_remote_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/watchlist_model.dart';
import '../models/history_model.dart';

class ProfileRemoteSource {
  final http.Client client;
  ProfileRemoteSource({required this.client});

  /// 🔹 احضار البيانات من API
  Future<List<WatchlistItem>> getWatchlist() async {
    final response = await client.get(Uri.parse(
        "https://movieapi-production.up.railway.app/watchlist"));

    final data = jsonDecode(response.body) as List;
    return data.map((e) => WatchlistItem.fromJson(e)).toList();
  }

  Future<List<HistoryItem>> getHistory() async {
    final response = await client.get(Uri.parse(
        "https://movieapi-production.up.railway.app/history"));

    final data = jsonDecode(response.body) as List;
    return data.map((e) => HistoryItem.fromJson(e)).toList();
  }

  /// 🔹 إضافة فيلم للـ Watchlist
  Future<void> addToWatchlist(WatchlistItem movie) async {
    await client.post(
      Uri.parse("https://movieapi-production.up.railway.app/watchlist"),
      body: jsonEncode(movie.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  }

  /// 🔹 تسجيل فيلم في History
  Future<void> addToHistory(HistoryItem movie) async {
    await client.post(
      Uri.parse("https://movieapi-production.up.railway.app/history"),
      body: jsonEncode(movie.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  }
}

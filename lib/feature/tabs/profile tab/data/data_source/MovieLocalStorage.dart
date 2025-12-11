import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/SavedMovie.dart';

class MovieLocalStorage {

  static Future<List<SavedMovie>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("watchlist") ?? "[]";
    return (json.decode(data) as List)
        .map((e) => SavedMovie.fromJson(e))
        .toList();
  }

  static Future<void> toggleWatchlist(SavedMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<SavedMovie> list = await getWatchlist();

    final exists = list.any((m) => m.id == movie.id);
    if (exists) list.removeWhere((m) => m.id == movie.id);
    else list.add(movie);

    prefs.setString("watchlist", json.encode(list));
  }

  // ⬅ إضافة History عند فتح MovieDetails
  static Future<void> addToHistory(SavedMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<SavedMovie> list = await getHistory();

    list.removeWhere((m) => m.id == movie.id);
    list.insert(0, movie);

    if (list.length > 20) list.removeLast(); // آخر 20 فيلم فقط
    prefs.setString("history", json.encode(list));
  }

  static Future<List<SavedMovie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("history") ?? "[]";
    return (json.decode(data) as List)
        .map((e) => SavedMovie.fromJson(e))
        .toList();
  }
}

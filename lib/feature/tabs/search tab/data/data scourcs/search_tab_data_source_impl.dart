// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/movie_model.dart';
// import 'search_tab_data_source.dart';
//
// class SearchTabDataSourceImpl implements SearchTabDataSource {
//   final http.Client client;
//
//   SearchTabDataSourceImpl({required this.client});
//
//   @override
//   Future<List<Movie>> fetchMovies({String? query}) async {
//     String url = "https://yts.lt/api/v2/list_movies.json?limit=50";
//     if (query != null && query.isNotEmpty) {
//       url += "&query_term=${Uri.encodeComponent(query)}";
//     }
//
//     final response = await client.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final moviesJson = data['data']?['movies'] as List<dynamic>?;
//       if (moviesJson == null) return [];
//       return moviesJson.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
//     } else {
//       throw Exception('Failed to load movies: ${response.statusCode}');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import 'search_tab_data_source.dart';

class SearchTabDataSourceImpl implements SearchTabDataSource {
  final http.Client client;

  SearchTabDataSourceImpl({required this.client});

  @override
  Future<List<Movie>> fetchMovies({String? query}) async {
    String url = "https://yts.lt/api/v2/list_movies.json?limit=50";
    if (query != null && query.isNotEmpty) {
      url += "&query_term=${Uri.encodeComponent(query)}";
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final moviesJson = data['data']?['movies'] as List<dynamic>?;
      if (moviesJson == null) return [];
      return moviesJson
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}

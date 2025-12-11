// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../data scourcs/search_tab_data_source.dart';
// import '../models/movie_model.dart';
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

// import 'package:movie_app/feature/tabs/search%20tab/data/repository_impl/search_tab_repository..dart';
//
// import '../../data/models/movie_model.dart';
// import '../data scourcs/search_tab_data_source.dart';
//
// class SearchTabRepositoryImpl implements SearchRepository {
//   final SearchTabDataSource dataSource;
//
//   SearchTabRepositoryImpl({required this.dataSource});
//
//   @override
//   Future<List<Movie>> searchMovies({String? query}) {
//     return dataSource.fetchMovies(query: query);
//   }
// }

// feature/tabs/search_tab/data/repository_impl/search_tab_repository_impl.dart

import 'package:movie_app/feature/tabs/search%20tab/data/repository_impl/search_tab_repository..dart';

import '../models/movie_model.dart';
import '../data scourcs/search_tab_data_source.dart';

class SearchTabRepositoryImpl implements SearchRepository {
  final SearchTabDataSource dataSource;

  SearchTabRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> fetchMovies({required String query}) async {
    return await dataSource.fetchMovies(query: query);
  }
}



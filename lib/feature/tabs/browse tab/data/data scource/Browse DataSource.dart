import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class BrowseDataSource {
  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(String genre);
}

class BrowseDataSourceImpl implements BrowseDataSource {
  final http.Client client;

  BrowseDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(String genre) async {
    final url = "https://yts.lt/api/v2/list_movies.json?limit=50&genre=$genre";
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data']['movies'] ?? []);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

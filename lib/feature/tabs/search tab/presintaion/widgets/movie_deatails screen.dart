import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            movie.largeCoverImage != null
                ? Image.network(movie.largeCoverImage!)
                : movie.mediumCoverImage != null
                ? Image.network(movie.mediumCoverImage!)
                : Container(height: 200, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Year: ${movie.year}", style: const TextStyle(color: Colors.white70, fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Rating: ${movie.rating}", style: const TextStyle(color: Colors.white70, fontSize: 18)),
                  const SizedBox(height: 16),
                  Text(movie.summary ?? "No description available.", style: const TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

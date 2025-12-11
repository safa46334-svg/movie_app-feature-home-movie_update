import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/data scource/Browse DataSource.dart';
import '../../data/repository/Browse Repository.dart';
import '../../domain/UseCase/FetchMoviesByGenreUseCase.dart';

import '../state&cubit/BrowseState.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final List<String> genres = [
    'Action','Adventure','Comedy','Drama','Horror','Romance',
    'Sci-Fi','Thriller','Fantasy','Animation','Crime','Mystery'
  ];

  String selectedGenre = 'Action';
  late final BrowseCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BrowseCubit(
      useCase: FetchMoviesByGenreUseCase(
        repository: BrowseRepositoryImpl(
          dataSource: BrowseDataSourceImpl(client: http.Client()),
        ),
      ),
    );
    _cubit.fetchMovies(selectedGenre);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    final isSelected = genre == selectedGenre;
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedGenre = genre);
                        _cubit.fetchMovies(genre);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.yellow : Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<BrowseCubit, BrowseState>(
                  builder: (context, state) {
                    if (state is BrowseLoading) {
                      return const Center(child: CircularProgressIndicator(color: Colors.yellow));
                    } else if (state is BrowseEmpty) {
                      return const Center(
                        child: Text("No movies found", style: TextStyle(color: Colors.white)),
                      );
                    } else if (state is BrowseLoaded) {
                      final movies = state.movies;
                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return MovieCard(movie: movie);
                        },
                      );
                    } else if (state is BrowseError) {
                      return Center(
                        child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.white)),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Map movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: movie['medium_cover_image'] != null
                ? ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(movie['medium_cover_image'], fit: BoxFit.cover),
            )
                : Container(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie['title'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(movie['year']?.toString() ?? '', style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

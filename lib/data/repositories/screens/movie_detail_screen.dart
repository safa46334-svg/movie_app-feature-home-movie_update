import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';
import 'package:movie_app/feature/tabs/search tab/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<Movie> _movieFuture;
  late Future<List<Movie>> _similarMoviesFuture;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _movieFuture = MovieRepository().getMovieDetails(widget.movieId);
    _similarMoviesFuture = MovieRepository().getSimilarMovies(widget.movieId);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw Exception("Could not launch");
  }

  void _toggleWatchlist() {
    setState(() => _isInWatchlist = !_isInWatchlist);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _isInWatchlist ? AppColors.green : AppColors.red,
        content: Text(_isInWatchlist ? "Added to Watchlist" : "Removed from Watchlist"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: FutureBuilder<Movie>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
          }

          if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData) return const Center(child: Text("Movie not found"));

          final movie = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 400,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(movie.largeCoverImage, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, AppColors.black.withOpacity(.8), AppColors.black],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(_isInWatchlist ? Icons.bookmark : Icons.bookmark_border,
                        color: AppColors.yellow, size: 27),
                    onPressed: _toggleWatchlist,
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Title
                      Text(movie.title,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.white),
                      ),
                      const SizedBox(height: 8),
                      Text("${movie.year}", style: const TextStyle(color: AppColors.gray)),

                      const SizedBox(height: 20),

                      /// Watch Button
                      ElevatedButton(
                        onPressed: () => _launchUrl("https://yts.mx/movies/${movie.title.toLowerCase().replaceAll(' ','-')}-${movie.year}"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("WATCH", style: TextStyle(fontSize: 18, color: AppColors.black)),
                      ),
                      const SizedBox(height: 25),

                      /// Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          movieStat(icon: Icons.star, value: "${movie.rating}/10", label: "Rating"),
                          movieStat(icon: Icons.access_time, value: "${movie.runtime} min", label: "Duration"),
                          movieStat(icon: Icons.language, value: movie.language?.toUpperCase() ?? "EN", label: "Lang"),
                        ],
                      ),
                      const SizedBox(height: 30),

                      /// ---------------- Screenshots ----------------
                      if (movie.screenshots.isNotEmpty) ...[
                        sectionTitle("Screenshots"),
                        SizedBox(
                          height: 170,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.screenshots.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 14),
                            itemBuilder: (_, i) => ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(movie.screenshots[i], fit: BoxFit.cover, width: 260),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],

                      /// ---------------- Similar Movies ----------------
                      sectionTitle("Similar Movies"),
                      FutureBuilder<List<Movie>>(
                        future: _similarMoviesFuture,
                        builder: (_, snap) {
                          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                          final similar = snap.data!;
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: similar.length,
                              itemBuilder: (_, i) => InkWell(
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: similar[i].id))),
                                child: Container(
                                  width: 130, margin: const EdgeInsets.only(right: 12),
                                  child: Column(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(similar[i].mediumCoverImage,
                                          fit: BoxFit.cover, height: 150, width: 130),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(similar[i].title, maxLines: 2,
                                        overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                                    Row(children: [
                                      const Icon(Icons.star, color: AppColors.yellow, size: 15),
                                      Text(similar[i].rating.toString(),
                                          style: const TextStyle(color: AppColors.yellow))
                                    ])
                                  ]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),

                      /// ---------------- Summary ----------------
                      if(movie.summary != null) ...[
                        sectionTitle("Summary"),
                        Text(movie.summary!, style: const TextStyle(color: AppColors.gray, fontSize: 15, height: 1.5)),
                        const SizedBox(height: 30),
                      ],

                      /// ---------------- Cast ----------------
                      if (movie.cast.isNotEmpty) ...[
                        sectionTitle("Cast"),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.cast.length,
                            itemBuilder: (_, i) => CastCard(castMember: movie.cast[i]),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget movieStat({required IconData icon, required String value, required String label}) =>
      Column(children: [
        CircleAvatar(backgroundColor: AppColors.gray, radius: 30,
            child: Icon(icon, color: AppColors.yellow, size: 28)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: AppColors.gray, fontSize: 12)),
      ]);
}

class CastCard extends StatelessWidget {
  final CastMember castMember;

  const CastCard({Key? key, required this.castMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, margin: const EdgeInsets.only(right: 16),
      child: Column(children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: castMember.imageUrl != null ? NetworkImage(castMember.imageUrl!) : null,
          child: castMember.imageUrl == null
              ? const Icon(Icons.person, color: Colors.grey, size: 45)
              : null,
        ),
        const SizedBox(height: 10),
        Text(castMember.name, maxLines: 2, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        Text(castMember.characterName,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center, maxLines: 2)
      ]),
    );
  }
}

/// ---------- Header Title ----------
Widget sectionTitle(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: Text(text,
      style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
);

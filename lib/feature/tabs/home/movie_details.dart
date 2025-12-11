
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/repositories/movie_repository.dart';
import '../search tab/data/models/movie_model.dart';

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

  void _toggleWatchlist() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isInWatchlist ? 'Added to Watchlist' : 'Removed from Watchlist',
          ),
          backgroundColor: _isInWatchlist ? AppColors.green : AppColors.red,
        ),
      );
    });
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: FutureBuilder<Movie>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellow),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.hasError
                    ? 'Error: ${snapshot.error}'
                    : 'Movie not found',
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }

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
                      Image.network(
                        movie.largeCoverImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: AppColors.gray),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.black.withOpacity(0.7),
                              AppColors.black,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isInWatchlist
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: AppColors.yellow,
                      size: 28,
                    ),
                    onPressed: _toggleWatchlist,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${movie.year}',
                        style: const TextStyle(
                          color: AppColors.gray,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _launchUrl(
                              'https://yts.mx/movies/${movie.title.toLowerCase().replaceAll(' ', '-')}-${movie.year}',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellow,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'WATCH NOW',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat(Icons.star, '${movie.rating}/10', 'Rating'),
                          _buildStat(Icons.access_time, '${movie.runtime} min', 'Duration'),
                          _buildStat(Icons.language, movie.language?.toUpperCase() ?? 'EN', 'Language'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (movie.screenshots.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Screenshots',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movie.screenshots.length > 3 ? 3 : movie.screenshots.length,
                                itemBuilder: (context, index) {
                                  return _buildImageCard(movie.screenshots[index]);
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      _buildSimilarMovies(),
                      if (movie.summary != null && movie.summary!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Summary',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.gray.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                movie.summary!,
                                style: const TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 16,
                                  height: 1.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      if (movie.cast.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cast',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movie.cast.length,
                                itemBuilder: (context, index) {
                                  return CastCard(castMember: movie.cast[index]);
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      if (movie.genres.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Genres',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: movie.genres.map((genre) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppColors.yellow),
                                  ),
                                  child: Text(
                                    genre,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
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

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.gray,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.yellow, width: 2),
          ),
          child: Icon(icon, color: AppColors.yellow, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.gray, fontSize: 12)),
      ],
    );
  }

  Widget _buildImageCard(String imageUrl) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.gray,
            child: const Icon(Icons.image_not_supported, color: AppColors.gray, size: 50),
          ),
        ),
      ),
    );
  }

  Widget _buildSimilarMovies() {
    return FutureBuilder<List<Movie>>(
      future: _similarMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(height: 220, child: Center(child: CircularProgressIndicator(color: AppColors.yellow)));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(height: 220, child: Center(child: Text('No similar movies found', style: TextStyle(color: AppColors.gray))));
        }

        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Similar Movies', style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length > 4 ? 4 : movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  double cardWidth = MediaQuery.of(context).size.width * 0.35;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: movie.id)),
                      );
                    },
                    child: Container(
                      width: cardWidth,
                      margin: EdgeInsets.only(right: index < movies.length - 1 ? 12 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.mediumCoverImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.gray,
                                  child: const Icon(Icons.movie, color: AppColors.gray, size: 40),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.yellow, size: 14),
                              const SizedBox(width: 4),
                              Text(movie.rating.toStringAsFixed(1), style: const TextStyle(color: AppColors.yellow, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}

class CastCard extends StatelessWidget {
  final CastMember castMember;
  const CastCard({Key? key, required this.castMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.yellow, width: 2),
              image: castMember.imageUrl != null
                  ? DecorationImage(image: NetworkImage(castMember.imageUrl!), fit: BoxFit.cover)
                  : null,
            ),
            child: castMember.imageUrl == null
                ? const Icon(Icons.person, color: AppColors.gray, size: 40)
                : null,
          ),
          const SizedBox(height: 12),
          Text(castMember.name,
              style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2),
          Text(castMember.characterName,
              style: const TextStyle(color: AppColors.gray, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2),
        ],
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:movie_app/core/resourses/app_colors.dart';
// // import 'package:movie_app/data/models/movie_model.dart';
// //
// // class MovieCard extends StatelessWidget {
// //   final Map movie;
// //   const MovieCard({super.key, required this.movie});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         // لاحقًا: افتح صفحة تفاصيل الفيلم
// //       },
// //       child: Card(
// //         color: Colors.grey[900],
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Expanded(
// //               child: movie['medium_cover_image'] != null
// //                   ? ClipRRect(
// //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                 child: Image.network(
// //                   movie['medium_cover_image'],
// //                   fit: BoxFit.cover,
// //                 ),
// //               )
// //                   : Container(color: Colors.grey),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     movie['title'] ?? '',
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     movie['year']?.toString() ?? '',
// //                     style: const TextStyle(
// //                       color: Colors.white70,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// import 'package:flutter/material.dart';
// import '../../data/models/movie_model.dart';
//
// class MovieCard extends StatelessWidget {
//   final Movie movie;
//   const MovieCard({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // لاحقًا: افتح صفحة تفاصيل الفيلم
//       },
//       child: Card(
//         color: Colors.grey[900],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: movie.mediumCoverImage != null
//                   ? ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   movie.mediumCoverImage!,
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Container(color: Colors.grey),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     movie.title ?? '',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     movie.year?.toString() ?? '',
//                     style: const TextStyle(
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import 'movie_deatails screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال لصفحة التفاصيل
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: movie.mediumCoverImage != null
                  ? ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  movie.mediumCoverImage!,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.year.toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

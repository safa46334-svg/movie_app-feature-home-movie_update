// // lib/feature/profile_tab/data/models/history_model.dart
// class HistoryItem {
//   final int movieId;
//   final String title;
//   final String coverImage;
//   final DateTime viewedAt;
//
//   HistoryItem({
//     required this.movieId,
//     required this.title,
//     required this.coverImage,
//     required this.viewedAt,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'movieId': movieId,
//     'title': title,
//     'coverImage': coverImage,
//     'viewedAt': viewedAt.toIso8601String(),
//   };
//
//   factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
//     movieId: json['movieId'],
//     title: json['title'],
//     coverImage: json['coverImage'],
//     viewedAt: DateTime.parse(json['viewedAt']),
//   );
// }
// lib/feature/profile/data/models/history_model.dart

class HistoryItem {
  final int movieId;
  final String title;
  final String coverImage;
  final DateTime watchedAt;

  HistoryItem({
    required this.movieId,
    required this.title,
    required this.coverImage,
    required this.watchedAt,
  });

  Map<String, dynamic> toJson() => {
    'movieId': movieId,
    'title': title,
    'coverImage': coverImage,
    'watchedAt': watchedAt.toIso8601String(),
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      movieId: json['movieId'],
      title: json['title'],
      coverImage: json['coverImage'],
      watchedAt: DateTime.parse(json['watchedAt']),
    );
  }
}

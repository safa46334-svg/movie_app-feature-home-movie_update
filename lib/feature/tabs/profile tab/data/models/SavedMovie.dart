class SavedMovie {
  final int id;
  final String title;
  final String image;

  SavedMovie({required this.id, required this.title, required this.image});

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };

  factory SavedMovie.fromJson(Map<String, dynamic> json) => SavedMovie(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );
}

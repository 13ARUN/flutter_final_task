class Movie {
  final String id;
  final String title;
  final String description;
  final String year;
  final List<String> genre;
  final String rating;
  final String image;
  final String bigImage;
  final String imdbLink;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.genre,
    required this.rating,
    required this.image,
    required this.bigImage,
    required this.imdbLink,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      year: json['year'].toString(),
      genre: List<String>.from(json['genre']),
      rating: json['rating'],
      image: json['image'],
      bigImage: json['big_image'],
      imdbLink: json['imdb_link'],
    );
  }
}

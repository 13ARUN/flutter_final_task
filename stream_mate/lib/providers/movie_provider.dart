import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_mate/models/movie.dart';
import 'package:stream_mate/services/api_service.dart';

final movieProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});

class MovieNotifier extends StateNotifier<List<Movie>> {
  MovieNotifier() : super([]);

  Future<void> loadMovies() async {
    try {
      final movies = await ApiService.fetchMovies();
      state = movies;
    } catch (e) {
      state = [];
    }
  }

  List<Movie> filterMovies(List<Movie> movies, String query) {
    final lowercasedQuery = query.toLowerCase();
    return movies.where((movie) {
      final title = movie.title.toLowerCase();
      return title.contains(lowercasedQuery);
    }).toList();
  }
}

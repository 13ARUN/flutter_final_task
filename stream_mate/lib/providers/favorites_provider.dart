import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Movie>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Movie>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Movie movie) {
    if (state.contains(movie)) {
      state = state.where((fav) => fav.id != movie.id).toList();
    } else {
      state = [...state, movie];
    }
  }
}

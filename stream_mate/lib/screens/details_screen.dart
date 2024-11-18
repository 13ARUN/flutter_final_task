import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_mate/models/movie.dart';
import 'package:stream_mate/providers/favorites_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends ConsumerWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(movie);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggleFavorite(movie),
            icon: isFavorite
                ? const Icon(Icons.star, color: Colors.amber)
                : const Icon(Icons.star_border, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.bigImage,
                  fit: BoxFit.cover,
                  height: 400,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Year: ${movie.year}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 16),
                Text(
                  'Rating: ${movie.rating}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Genre: ${movie.genre.join(', ')}',
              style: const TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 16),
            Text(
              movie.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              onPressed: () async {
                if (!await launchUrl(Uri.parse(movie.imdbLink))) {
                  throw Exception('Could not launch URL');
                }
              },
              child: const Text(
                'View on IMDb',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

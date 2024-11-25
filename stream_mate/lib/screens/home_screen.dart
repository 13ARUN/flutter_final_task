import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_mate/providers/movie_provider.dart';
import 'package:stream_mate/widgets/movie_card.dart';
import 'package:stream_mate/widgets/search_bar.dart';

import 'favorites_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String searchQuery = '';
  int _selectedIndex = 0;

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(movieProvider.notifier).loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieProvider);

    final filteredMovies =
        ref.watch(movieProvider.notifier).filterMovies(movies, searchQuery);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        title: const Text('Stream Mate', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _selectedIndex == 0
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchMoviesBar(
                      onSearch: (query) => setState(() => searchQuery = query),
                    ),
                  ),
                  Expanded(
                    child: filteredMovies.isEmpty
                        ? const Center(
                            child: Text("No movies found",
                                style: TextStyle(color: Colors.white)))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2 / 3,
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemCount: filteredMovies.length,
                            itemBuilder: (context, index) {
                              return MovieCard(movie: filteredMovies[index]);
                            },
                          ),
                  ),
                ],
              )
            : const FavoritesScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onBottomItemTapped,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        elevation: 8,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SearchMoviesBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchMoviesBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearch,
        decoration: const InputDecoration(
          hintText: 'Search movies...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

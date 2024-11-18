import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stream_mate/constants/api_constants.dart';
import 'package:stream_mate/models/movie.dart';

class ApiService {
  static Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.baseUrl),
          headers: ApiConstants.headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching movies: $e');
    }
  }
}

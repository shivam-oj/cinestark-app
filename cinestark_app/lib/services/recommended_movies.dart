import 'dart:convert';
import 'package:http/http.dart';
import 'package:cinestark_app/models/movie.dart';


class RecommendedMovies {
  final int movieId;
  List<Movie> recommendedMovies = [];

  RecommendedMovies({ required this.movieId });

  Future<List<Movie>> getRecommendedMovies() async {
    try {
      Response response = await get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=ec5e239f5a72d82923adff04f4ae819d'));
      Map data = jsonDecode(response.body);

      List movies = data['results'];

      for (var mv in movies) {
        Movie movie = Movie(
            movieId: mv['id'],
            title: mv['title'],
            posterPath: mv['poster_path'],
            genreIds: mv['genre_ids'],
            overview: mv['overview'],
            releaseDate: mv['release_date']
        );

        recommendedMovies.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return recommendedMovies;
  }

}

import 'dart:convert';
import 'package:http/http.dart';
import 'package:cinestark_app/models/movie.dart';


class TrendingMovies {
  List<Movie> trendingMovies = [];

  Future<void> getTrendingMovies() async {
    try {
      Response response = await get(Uri.parse('https://api.themoviedb.org/3/trending/movie/day?'));
      Map data = jsonDecode(response.body);

      List movies = data['results'];

      for (var mv in movies) {
        Movie movie = Movie(
            movieId: mv['id'],
            title: mv['title'],
            posterPath: mv['poster_path'],
        );

        trendingMovies.add(movie);
      }

    } catch (e) {
      print(e);
    }
  }

}

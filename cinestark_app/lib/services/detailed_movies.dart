import 'dart:convert';
import 'package:http/http.dart';
import 'package:cinestark_app/models/movie.dart';


class DetailedMovie {
  final int movieId;

  DetailedMovie({ required this.movieId });

  Future<Movie?> getMovieDetails() async {
    Movie? movie;

    try {
      Response response = await get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=ec5e239f5a72d82923adff04f4ae819d'));
      Map data = jsonDecode(response.body);

      List<dynamic> genreIds = [];
      List<dynamic> genres = [];
      for (var genre in data['genres']) {
        genreIds.add(genre['id']);
        genres.add(genre['name']);
      }

      movie = Movie(
        movieId: movieId,
        title: data['title'],
        posterPath: data['poster_path'],
        genreIds: genreIds,
        genres: genres,
        overview: data['overview']
      );

    } catch (e) {
      print(e);
    }

    return movie;
  }

}

class Movie {

  final int? movieId, voteCount;
  final double? popularity, voteAverage;
  final String? backdropPath, title, originalTitle, overview, posterPath, mediaType, originalLanguage, releaseDate;
  final bool? adult, video;
  final List<dynamic>? genreIds, genres;

  Movie({
    required this.movieId,
    this.backdropPath,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.genres,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

}

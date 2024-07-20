import 'dart:convert';
import 'package:flutter/cupertino.dart';


String genresFile = 'lib/models/genres.json';

Future<List<dynamic>> readGenres(String genresFile, BuildContext context) async {
  var input = await DefaultAssetBundle.of(context).loadString(genresFile);
  var map = jsonDecode(input);
  return map['genres'];
}

Future<List<String>> getGenres(List<dynamic>? genreIds, BuildContext context) async {
  List<dynamic> genres = await readGenres(genresFile, context);
  Map<int, String> genreMap = {};
  for (Map genre in genres) {
    genreMap[genre['id']] = genre['name'];
  }

  List<String> genreNames = [];

  if (genreIds != null) {
    for (int genreId in genreIds) {
      genreNames.add(genreMap[genreId]!);
    }
  }

  return genreNames;
}

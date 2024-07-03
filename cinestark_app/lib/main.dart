import 'package:flutter/material.dart';
import 'package:cinestark_app/screens/loading.dart';
import 'package:cinestark_app/screens/home.dart';
import 'package:cinestark_app/screens/movie_details.dart';
import 'package:cinestark_app/screens/movie_search.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (globalContext) => const Loading(),
    '/home': (globalContext) => const Home(),
    '/movie-details': (globalContext) => const MovieDetails(),
    '/movie-search': (globalContext) => const MovieSearch(),
  },
));

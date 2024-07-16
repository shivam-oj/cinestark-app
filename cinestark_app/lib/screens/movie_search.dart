import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:cinestark_app/services/search_movies.dart';
import 'package:cinestark_app/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sticky_headers/sticky_headers.dart';


class MovieSearch extends StatefulWidget {
  const MovieSearch({super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  List<Movie> movies = [];
  final _movieNameController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CineStarkAppBar()
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(itemCount: 1, itemBuilder: (context, index) {
        return StickyHeader(
          header: SearchBar(
            controller: _movieNameController,
            onSubmitted: (_) async {
              SearchMovies instance = SearchMovies(_movieNameController.text);
              await instance.getMovies();
              setState(() {
                movies = instance.searchedMovies;
              });
            },
            leading: const Icon(Icons.search),
          ),
          content: Container(
              color: Colors.black,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black12,
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                            width: 60,
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original${movies[index]
                                  .posterPath}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Text(
                              movies[index].title.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            " (${movies[index].releaseDate.toString().split('-')[0]})",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        Navigator.pushNamed(context, '/movie-details',
                            arguments: { 'movie': movies[index]});
                      },
                    ),
                  );
                },
              )
          ),
        );
      }),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

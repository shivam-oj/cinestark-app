import 'package:flutter/material.dart';
import 'package:cinestark_app/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';


class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    Movie movie = data['movie'];

    return Scaffold(
      appBar: cineStarkAppBar,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.black12,
              child: Column(
                children: <Widget>[
                  Text(
                      '${movie.title}',
                      style : const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      )
                  ),
                  SizedBox(
                    height: 250,
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/original${movie.posterPath}?',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.black12,
              child: Column(
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.genreIds?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              movie.genreIds![index].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.black12,
              child: Column(
                children: <Widget>[
                  const Text(
                      'Plot',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Text(
                    movie.overview.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                      });
                    },
                    icon: const Icon(
                      Icons.thumb_down,
                      size: 50.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(width: 250.0),
                  IconButton(
                      onPressed: () {
                        setState(() {
                        });
                      },
                      icon: const Icon(
                        Icons.thumb_up,
                        size: 50.0,
                        color: Colors.deepPurple,
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

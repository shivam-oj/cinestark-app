import 'package:flutter/material.dart';
import 'package:cinestark_app/models/movie.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    List<Movie> movies = data['trendingMovies'];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text(
          'CineStark',
          style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontFamily: 'IndieFlower'
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.black12,
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 140,
                      width: 100,
                      child: Image.network(
                          'https://image.tmdb.org/t/p/original${movies[index].posterPath}',
                          fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                        movies[index].title.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.pushNamed(context, '/movie-details', arguments: { 'movie': movies[index] });
                },
              ),
            );
          }
      ),
    );
  }
}

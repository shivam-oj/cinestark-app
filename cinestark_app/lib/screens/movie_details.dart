import 'package:cinestark_app/services/genres.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:cinestark_app/models/user.dart';
import 'package:cinestark_app/services/database.dart';
import 'package:cinestark_app/shared/screen_loading.dart';


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

    final user = Provider.of<AppUser?>(context);

    return StreamBuilder<UserData>(
      stream: user != null ? DatabaseService(uid: user.uid).userData : null,
      builder: (context, snapshot) {

        bool inWatchList = false;
        bool liked = false;
        bool disliked = false;

        List<dynamic> watchList = [];
        List<dynamic> likedMovies = [];
        List<dynamic> dislikedMovies = [];

        bool isSignedIn = snapshot.hasData;

        if (isSignedIn) {
          UserData? userData = snapshot.data;
          watchList = userData?.watchList ?? [];
          likedMovies = userData?.likedMovies ?? [];
          dislikedMovies = userData?.dislikedMovies ?? [];

          if (watchList.contains(movie.movieId.toString())) {
            inWatchList = true;
          }
          if (likedMovies.contains(movie.movieId.toString())) {
            liked = true;
          }
          if (dislikedMovies.contains(movie.movieId.toString())) {
            disliked = true;
          }
        }

        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CineStarkAppBar()
          ),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.genreIds?.length,
                            itemBuilder: (context, index) {
                              if (movie.genres == null) {
                                return FutureBuilder(
                                  future: getGenres(movie.genreIds, context),
                                  builder: (context, genres) {
                                    if (genres.hasData) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                        ),
                                        color: Colors.grey,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            genres.data![index],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const ScreenLoading();
                                    }
                                  },
                                );
                              } else {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  color: Colors.grey,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      movie.genres?[index],
                                    ),
                                  ),
                                );
                              }
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        color: Colors.grey,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            movie.overview.toString(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: Colors.black12,
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: isSignedIn,
                        child: IconButton(
                          onPressed: () {
                            if (!disliked) {
                              dislikedMovies.add(movie.movieId.toString());
                              DatabaseService(uid: user!.uid).updateDislikedMovies(dislikedMovies);
                            }
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            size: 50.0,
                            color: disliked ? Colors.deepPurple : Colors.deepPurple[100],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: isSignedIn,
                        child: IconButton(
                            onPressed: () {
                              if (!liked) {
                                likedMovies.add(movie.movieId.toString());
                                DatabaseService(uid: user!.uid).updateLikedMovies(likedMovies);
                              }
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              size: 50.0,
                              color: liked ? Colors.deepPurple : Colors.deepPurple[100],
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: isSignedIn,
            child: FloatingActionButton.extended(
                label: const Icon(Icons.add),
                backgroundColor: inWatchList? Colors.deepPurple : Colors.deepPurple[100],
                onPressed: () {
                  if (!inWatchList) {
                    watchList.add(movie.movieId.toString());
                    DatabaseService(uid: user!.uid).updateWatchList(watchList);
                  }
                },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: const CineStarkBottomNavigationBar(),
        );
      }
    );
  }
}

import 'package:cinestark_app/services/recommended_movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinestark_app/models/user.dart';
import 'package:cinestark_app/models/movie.dart';
import 'package:cinestark_app/services/database.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:cinestark_app/shared/screen_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sticky_headers/sticky_headers.dart';


class MovieRecommendations extends StatefulWidget {
  const MovieRecommendations({super.key});

  @override
  State<MovieRecommendations> createState() => _MovieRecommendationsState();
}

class _MovieRecommendationsState extends State<MovieRecommendations> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    final userDbService = DatabaseService(uid: user!.uid);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CineStarkAppBar()
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<UserData>(
        stream: userDbService.userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            userDbService.updateInterestedMovies(userData!.likedMovies, userData.watchList, userData.dislikedMovies);
            List<dynamic> interestedMovies = userData.interestedMovies;

            if (interestedMovies.isNotEmpty) {
              return FutureBuilder(
                  future: RecommendedMovies(movieId: int.parse((interestedMovies..shuffle()).first)).getRecommendedMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Movie>? movies = snapshot.data;
                      return ListView.builder(itemCount: 1, itemBuilder: (context, index) {
                        return StickyHeader(
                          header: Container(
                            height: 40.0,
                            color: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recommended movies for you, ${userData.firstName}',
                              style: const TextStyle(color: Colors.deepPurple, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Container(
                            color: Colors.black,
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: movies?.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.black12,
                                    child: InkWell(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 140,
                                            width: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: 'https://image.tmdb.org/t/p/original${movies?[index].posterPath}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              movies![index].title.toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.0,
                                                color: Colors.white,
                                              ),
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
                          ),
                        );
                      });
                    } else {
                      return const ScreenLoading();
                    }
                  }
              );
            } else {
              return Column(
                children: [
                  const Text(
                      'Please like a few movies or add them to your watchlist to get recommendations..',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IndieFlower',
                          letterSpacing: 1.0
                      ),
                  ),
                  const SizedBox(height: 100.0),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_sharp, color: Colors.yellow, size: 50.0),
                    onPressed: () {},
                  )
                ],
              );
            }
          } else {
            return const ScreenLoading();
          }
        },
      ),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

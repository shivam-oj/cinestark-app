import 'package:cinestark_app/models/movie.dart';
import 'package:cinestark_app/services/database.dart';
import 'package:cinestark_app/services/detailed_movies.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:cinestark_app/models/user.dart';
import 'package:cinestark_app/shared/screen_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            List<dynamic> movies = userData!.watchList;
            return Scaffold(
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: CineStarkAppBar()
              ),
              backgroundColor: Colors.grey,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(25.0),
                            child: const CircleAvatar(
                              radius: 48,
                              backgroundImage: AssetImage('assets/turtle.jpg') as ImageProvider,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${userData.firstName} ${userData.lastName}",
                                style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.email, color: Colors.deepPurple, size: 30.0),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    userData.email,
                                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Container(
                      height: 40.0,
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${userData.firstName}'s Watchlist",
                        style: const TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: DetailedMovie(movieId: int.parse(movies[index])).getMovieDetails(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Movie? movie = snapshot.data;
                                    return Card(
                                      color: Colors.black12,
                                      child: InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 140,
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://image.tmdb.org/t/p/original${movie?.posterPath}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                movie!.title.toString(),
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
                                          Navigator.pushNamed(context, '/movie-details', arguments: { 'movie': movie });
                                        },
                                      ),
                                    );
                                  } else {
                                    return const ScreenLoading();
                                  }
                                }
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: const CineStarkBottomNavigationBar(),
            );
          } else {
            return const ScreenLoading();
          }
        }
    );
  }
}

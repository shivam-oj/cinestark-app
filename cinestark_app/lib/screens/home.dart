import 'package:flutter/material.dart';
import 'package:cinestark_app/models/movie.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:cinestark_app/models/user.dart';


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

    final user = Provider.of<AppUser?>(context);
    print('User: ');
    print(user);
    print('UID: ');
    print(user?.uid);

    return Scaffold(
      appBar: cineStarkAppBar,
      backgroundColor: Colors.black,
      body: ListView.builder(itemCount: 1, itemBuilder: (context, index) {
        return StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Trending Now',
                style: TextStyle(color: Colors.deepPurple, fontSize: 20,fontWeight: FontWeight.bold),
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
                              child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/original${movies[index].posterPath}',
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
            ),
        );
      }),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

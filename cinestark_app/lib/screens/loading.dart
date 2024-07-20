import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cinestark_app/services/trending_movies.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupTrendingMovies() async {
    TrendingMovies instance = TrendingMovies();
    await instance.getTrendingMovies();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'trendingMovies': instance.trendingMovies,
    });
  }

  @override
  void initState() {
    super.initState();
    setupTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
        ),
      ),
    );
  }
}

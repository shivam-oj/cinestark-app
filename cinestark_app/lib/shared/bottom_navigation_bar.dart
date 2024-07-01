import 'package:flutter/material.dart';
import 'package:cinestark_app/screens/home.dart';
import 'package:cinestark_app/services/trending_movies.dart';


class CineStarkBottomNavigationBar extends StatefulWidget {
  const CineStarkBottomNavigationBar({super.key});

  @override
  State<CineStarkBottomNavigationBar> createState() => _CineStarkBottomNavigationBarState();
}

class _CineStarkBottomNavigationBarState extends State<CineStarkBottomNavigationBar> {

  // int _currentIndex = 0;
  final List<Widget> _screens = [const Home(), const Home(), const Home()];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple,
      // currentIndex: _currentIndex,
      onTap: (index) async {
        TrendingMovies instance = TrendingMovies();
        await instance.getTrendingMovies();
        Navigator.pushNamed(context, '/home', arguments: {
          'trendingMovies': instance.trendingMovies,
        });
      },
      // onTap: (index) {
      //   setState(() {
      //     Home();
      //   });
      // },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.black),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          label: 'User',
        ),
      ],
    );
  }
}

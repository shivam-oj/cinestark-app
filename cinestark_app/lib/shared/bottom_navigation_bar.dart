import 'package:flutter/material.dart';


class CineStarkBottomNavigationBar extends StatefulWidget {
  const CineStarkBottomNavigationBar({super.key});

  @override
  State<CineStarkBottomNavigationBar> createState() => _CineStarkBottomNavigationBarState();
}


class _CineStarkBottomNavigationBarState extends State<CineStarkBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 50.0),
            onPressed: () async {
              Navigator.pushNamed(context, '/movie-search');
            },
          ),
          const SizedBox(width: 200.0),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black, size: 50.0),
            onPressed: () async {
              Navigator.pushNamed(context, '/authenticate');
            },
          )
        ],
      ),
    );
  }
}

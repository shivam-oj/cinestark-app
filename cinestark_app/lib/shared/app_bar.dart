import 'package:flutter/material.dart';
import 'package:cinestark_app/services/auth.dart';
import 'package:cinestark_app/services/is_signed_in.dart';


class CineStarkAppBar extends StatefulWidget {
  const CineStarkAppBar({super.key});

  @override
  State<CineStarkAppBar> createState() => _CineStarkAppBarState();
}

class _CineStarkAppBarState extends State<CineStarkAppBar> {
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      title: const Text(
        'CineStark',
        style: TextStyle(
          color: Colors.black,
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'IndieFlower'
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          icon: Visibility(
            visible: isSignedIn(context),
            child: const Icon(Icons.logout, color: Colors.black, size: 50.0),
          ),
          onPressed: () async {
            await _auth.signOut();
          },
        )
      ],
    );
  }
}

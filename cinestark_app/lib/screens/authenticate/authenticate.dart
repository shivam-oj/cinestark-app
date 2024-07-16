import 'package:cinestark_app/screens/authenticate/register.dart';
import 'package:cinestark_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // bool showSignIn = true;
  //
  // void toggleView() {
  //   setState(() => showSignIn = !showSignIn);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CineStarkAppBar(),
      ),
      backgroundColor: Colors.purple[100],
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SignIn(),
            Register()
          ],
        ),
      ),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

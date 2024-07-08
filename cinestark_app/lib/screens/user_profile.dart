import 'package:flutter/material.dart';
import 'package:cinestark_app/shared/app_bar.dart';
import 'package:cinestark_app/shared/bottom_navigation_bar.dart';
import 'package:cinestark_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cinestark_app/models/user.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    return Scaffold(
      appBar: cineStarkAppBar,
      backgroundColor: Colors.brown[100],
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
                  Text(
                    user!.uid,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15.0),
            ElevatedButton(
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  await _auth.signOut();
                }
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CineStarkBottomNavigationBar(),
    );
  }
}

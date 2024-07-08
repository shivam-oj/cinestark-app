import 'package:cinestark_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/services/is_signed_in.dart';
import 'package:cinestark_app/screens/user_profile.dart';


class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    if (isSignedIn(context)) {
      return const UserProfile();
    } else {
      return const Authenticate();
    }
  }
}

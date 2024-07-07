import 'package:cinestark_app/models/user.dart';
import 'package:cinestark_app/screens/authenticate/authenticate.dart';
import 'package:cinestark_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

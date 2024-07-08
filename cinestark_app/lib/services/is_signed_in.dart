import 'package:flutter/material.dart';
import 'package:cinestark_app/models/user.dart';
import 'package:provider/provider.dart';


bool isSignedIn(BuildContext context) {
  final user = Provider.of<AppUser?>(context);
  return user != null;
}

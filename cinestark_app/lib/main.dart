import 'package:cinestark_app/models/user.dart';
import 'package:cinestark_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cinestark_app/screens/loading.dart';
import 'package:cinestark_app/screens/home.dart';
import 'package:cinestark_app/screens/movie_details.dart';
import 'package:cinestark_app/screens/movie_search.dart';
import 'package:cinestark_app/screens/user.dart';
import 'package:provider/provider.dart';


void main() async {
  String defaultFirebaseOption = 'default';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: 'AIzaSyDQ6igHo_kjIBXv9liqdBoYg0_p1MfqF5Q', appId: defaultFirebaseOption, messagingSenderId: defaultFirebaseOption, projectId: 'cins-467-c96a2')
  );

  return runApp(
    StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (globalContext) => const Loading(),
          '/home': (globalContext) => const Home(),
          '/movie-details': (globalContext) => const MovieDetails(),
          '/movie-search': (globalContext) => const MovieSearch(),
          '/user': (globalContext) => const User(),
        },
      ),
    )
  );
}

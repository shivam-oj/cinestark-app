import 'package:cinestark_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    // return user != null ? AppUser(uid: user.uid) : null;
    if (user != null) {
      return AppUser(uid: user.uid);
    }
    throw ArgumentError(user);
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
    // return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnonymously() async {
    try {
      UserCredential cred = await _auth.signInAnonymously();
      User? user = cred.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = cred.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = cred.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}

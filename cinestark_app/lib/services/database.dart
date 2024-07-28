import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinestark_app/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updatePhotoURL(String photoURL) async {
    return await userCollection.doc(uid).update({
      'photoURL': photoURL,
    });
  }

  Future<void> updateWatchList(List<dynamic> watchList) async {
    return await userCollection.doc(uid).update({
      'watchList': watchList,
    });
  }

  Future<void> updateLikedMovies(List<dynamic> likedMovies) async {
    return await userCollection.doc(uid).update({
      'likedMovies': likedMovies,
    });
  }

  Future<void> updateDislikedMovies(List<dynamic> dislikedMovies) async {
    return await userCollection.doc(uid).update({
      'dislikedMovies': dislikedMovies,
    });
  }

  Future<void> updateUserData(String firstName, String? lastName, String email) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'watchList': [],
      'likedMovies': [],
      'dislikedMovies': [],
      'photoURL': null,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.get('firstName'),
        lastName: snapshot.get('lastName'),
        email: snapshot.get('email'),
        watchList: snapshot.get('watchList'),
        likedMovies: snapshot.get('likedMovies'),
        dislikedMovies: snapshot.get('dislikedMovies'),
        photoURL: snapshot.get('photoURL'),
    );
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

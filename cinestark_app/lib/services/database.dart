import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinestark_app/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateWatchList(List<dynamic> watchList) async {
    return await userCollection.doc(uid).update({
      'watchList': watchList,
    });
  }

  Future<void> updateUserData(String firstName, String? lastName, String email) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'watchList': [],
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.get('firstName'),
        lastName: snapshot.get('lastName'),
        email: snapshot.get('email'),
        watchList: snapshot.get('watchList'),
    );
  }

  Stream<UserData> get userData {
    print('start mapping');
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

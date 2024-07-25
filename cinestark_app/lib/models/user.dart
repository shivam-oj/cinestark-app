class AppUser {

  final String uid;

  AppUser({ required this.uid });

}


class UserData {

  final String uid, firstName, email;
  final String? lastName, photoURL;
  final List<dynamic> watchList;
  final List<dynamic> likedMovies;
  final List<dynamic> dislikedMovies;

  UserData({
    required this.uid,
    required this.firstName,
    this.lastName,
    this.photoURL,
    required this.email,
    required this.watchList,
    required this.likedMovies,
    required this.dislikedMovies
  });

}

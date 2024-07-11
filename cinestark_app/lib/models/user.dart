class AppUser {

  final String uid;

  AppUser({ required this.uid });

}


class UserData {

  final String uid, firstName, email;
  final String? lastName;
  final List<dynamic> watchList;

  UserData({ required this.uid, required this.firstName, this.lastName, required this.email, required this.watchList});

}

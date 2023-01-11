import 'package:firebase_database/firebase_database.dart';

class FirebasePath {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  //Defined path names
  static const String users = 'Users';

  //Defined paths
  static DatabaseReference userRef = ref.child(users);
}

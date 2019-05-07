import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  String displayName;
  User({@required this.displayName});

  static Future<User> currentUser() async {
    return FirebaseAuth.instance.currentUser().then(
      (firebaseUser) => createUser(firebaseUser),
      onError: (exp) => print('Error occured: $exp')
    );
  }

  static User createUser(FirebaseUser firebaseUser){
    return User(displayName: firebaseUser.displayName);
  }
}
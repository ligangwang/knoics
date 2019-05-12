import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  String displayName;
  User({@required this.displayName});

  @override
  String toString(){
    return displayName;
  }

  static Future<User> currentUser() async {
    return FirebaseAuth.instance.currentUser().then(
      (firebaseUser) => createUser(firebaseUser),
      onError: (exp) => print('Error occured: $exp')
    );
  }

  static User createUser(FirebaseUser firebaseUser){
    if(firebaseUser == null) return null;
    return User(displayName: firebaseUser.displayName);
  }

  static void signOut(){
    FirebaseAuth.instance.signOut();
  }

  static void onUserChange(onChange){
    FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser firebaseUser){
      User user = createUser(firebaseUser);
      onChange(user);
    }
    );
  }
}
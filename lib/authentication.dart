import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class Authentication{
  Future<User> signInWithGoogle() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if(firebaseUser!=null){
      print('current user: ${firebaseUser.displayName} already signed in');
      return User.createUser(firebaseUser);
    }

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    firebaseUser = await firebaseAuth.signInWithCredential(credential);
    return User.createUser(firebaseUser);
  }
}
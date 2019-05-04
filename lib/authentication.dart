import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  Future<FirebaseUser> signInWithGoogle() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if(firebaseUser!=null){
      print('current user: ${firebaseUser.displayName} already signed in');
      return firebaseUser;
    }
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }
}
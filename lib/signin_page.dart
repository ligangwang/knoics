import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SigninPage extends StatelessWidget{
  final auth = Authentication();

  @override
  Widget build(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: _handleSignin,
      icon: Image.asset('images/google-g-logo.png', height: 24.0),
      label: const Text('Sign in with Google'),
    );
  }

  void _handleSignin(){
    auth.signInWithGoogle().then((FirebaseUser user)=>print('HI ${user.displayName}'));
  }
} 
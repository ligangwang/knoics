import 'package:flutter/material.dart';
import 'authentication.dart';
import 'data/user.dart';


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

  void _handleSignin() async {
    User user = await auth.signInWithGoogle();
    print('HI ${user.displayName}');
  }
} 
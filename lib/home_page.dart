import 'package:flutter/material.dart';
import 'user.dart';
import 'signin_page.dart';

class HomePage extends StatelessWidget{
  final User _user;
  HomePage(this._user);
  
  @override
  Widget build(BuildContext context){
    String userName;
    if (_user == null){
      return SigninPage();
    }else{
      userName = _user.displayName;
    }
    return Scaffold(
      appBar: AppBar(title: Text('knoics-home')),
      body: Center(
        child: Row(
          children: <Widget>[
            Text('Hello $userName'),
            RaisedButton(child: Text("Sign Out"), onPressed: (){User.signOut(); print('signed out'); Navigator.pushNamed(context, '/');},)
          ],
        ),
      ),
    );
  }
}
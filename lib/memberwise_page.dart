import 'package:flutter/material.dart';
import 'data/user.dart';
import 'signin_page.dart';

abstract class MemberwisePage extends StatelessWidget{
  final User _user;
  final String _title;
  MemberwisePage(this._user, this._title);

  User get user {return _user;}

  Widget buildBody(BuildContext context);
  
  @override
  Widget build(BuildContext context){
    if (_user == null){
      return SigninPage();
    }
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: buildBody(context),
    );
  }
}

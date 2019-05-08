import 'package:flutter/material.dart';
import 'user.dart';

class UserPage extends StatelessWidget{
  final User _user;
  UserPage(this._user);
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('User')), 
      body: Center(child: Text('Hello ${_user.displayName}'),),
    );
  }
}
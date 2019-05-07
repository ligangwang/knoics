import 'package:flutter/material.dart';
import 'user.dart';


class HomePage extends StatefulWidget{
  @override
  State createState()=>new HomeState();
}

class HomeState extends State<HomePage>{
  User _user;
  
  @override
  void initState(){
    super.initState();
    User.currentUser().then((user)=>_user=user);
  }

  @override
  Widget build(BuildContext context){
    if (_user == null){
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('knoics')),
      body: Center(
        child: Text('Hello ${_user.displayName}')
      ),
    );
  }
}
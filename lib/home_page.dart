import 'package:flutter/material.dart';
import 'data/user.dart';
import 'memberwise_page.dart';

class HomePage extends MemberwisePage{
  HomePage(User user) : super(user, "home");
  
  @override
  Widget buildBody(BuildContext context){
    return Center(
      child: Row(
        children: <Widget>[
          FlatButton(child: Text('${user.displayName}'), onPressed: (){Navigator.pushNamed(context, '/user');},),
          FlatButton(child: Text('Concepts'), onPressed: (){Navigator.pushNamed(context, '/concept');},),
          RaisedButton(child: Text("Sign Out"), onPressed: (){User.signOut(); print('signed out'); Navigator.pushNamed(context, '/');},)
        ],
      ),
    );
  }
}
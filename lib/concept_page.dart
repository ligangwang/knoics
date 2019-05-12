import 'package:flutter/material.dart';
import 'memberwise_page.dart';
import 'user.dart';

class ConceptPage extends MemberwisePage{
  ConceptPage(User user) : super(user, "concept");

  @override
  Widget buildBody(BuildContext context){
    return Center(
        child: Row(
          children: <Widget>[
            FlatButton(child: Text('Hello $user.displayName'), onPressed: (){Navigator.pushNamed(context, '/user');},),
          ],
        ),
    );
  }
}
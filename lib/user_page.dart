import 'package:flutter/material.dart';
import 'user.dart';
import 'memberwise_page.dart';

class UserPage extends MemberwisePage{
  UserPage(User user) : super(user, 'user');
  
  @override
  Widget buildBody(BuildContext context){
    return Center(child: Text('Hello user: ${user.displayName}'),);
  }
}
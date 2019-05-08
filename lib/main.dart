import 'package:flutter/material.dart';
import 'home_page.dart';
import 'user_page.dart';
import 'user.dart';

void main() => runApp(KnoicsApp());

class KnoicsApp extends StatefulWidget{
  @override
  State createState()=>new KnoicsAppState();
}

class KnoicsAppState extends State<KnoicsApp> {
  User _user;

  @override
  void initState(){
    super.initState();
    User.onUserChange((user){
      setState((){_user=user; });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'knoics',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(_user),
        '/user': (context) => UserPage(_user),
      },
    );
  }
}


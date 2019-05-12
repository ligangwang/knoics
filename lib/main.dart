import 'package:flutter/material.dart';
import 'home_page.dart';
import 'user_page.dart';
import 'data/app_state.dart';
import 'concept_page.dart';

void main() => runApp(KnoicsApp());

class KnoicsApp extends StatefulWidget{
  @override
  State createState()=>new KnoicsAppState();
}

class KnoicsAppState extends State<KnoicsApp> {
  AppState _appState = AppState();

  @override
  void initState(){
    super.initState();
    _appState.onUserChange((user){
      setState((){});
    });
    _appState.navigateToConcept('science', (concept){
      setState((){});
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
        '/': (context) => HomePage(_appState.user),
        '/user': (context) => UserPage(_appState.user),
        '/concept': (context) => ConceptPage(_appState.user, _appState.concept),
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'data/app_state.dart';


class ConceptPage extends StatefulWidget{
  @override
  State createState()=>new _ConceptState();
}

class _ConceptState extends State<ConceptPage>{
  ConceptState _conceptState = ConceptState();

  @override
  void initState(){
    super.initState();
    _conceptState.navigateToConcept('science', (concept){
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context){
    if(_conceptState.concept == null){
      return Scaffold();
    }
    return Scaffold(
      appBar: AppBar(title: Text('concept')),
      body: Center(
        child: Text('${_conceptState.concept.description}')
      ),
    );
  }
}
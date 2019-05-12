import 'package:flutter/material.dart';
import 'memberwise_page.dart';
import 'data/user.dart';
import 'data/concept.dart';

class ConceptPage extends MemberwisePage{
  final Concept _concept;
  ConceptPage(User user, this._concept) : super(user, "concept");

  @override
  Widget buildBody(BuildContext context){
    return Center(
        child: Text('${_concept.description}')
    );
  }
}
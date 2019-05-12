import 'user.dart';
import 'concept.dart';
import 'wiki_api.dart';

class UserState{
  User _user;
  User get user {return _user;}

  void onUserChange(onChange){
    User.onUserChange((user){_user = user; onChange(user);});
  }
}


class ConceptState{
  Concept _concept;

  Concept get concept {return _concept;}
  void navigateToConcept(String conceptName, onChange) async{
    final description = await WikiAPI.getDescription(conceptName);
    _concept = Concept.fromJson(conceptName, description);
    onChange(_concept);
  }
}

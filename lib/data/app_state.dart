import 'user.dart';
import 'concept.dart';
import 'wiki_api.dart';

class AppState{
  User _user;
  Concept _concept;

  User get user {return _user;}
  Concept get concept {return _concept;}

  void onUserChange(onChange){
    User.onUserChange((user){_user = user; onChange(user);});
  }

  void navigateToConcept(String conceptName, onChange) async{
    final description = await WikiAPI.getDescription(conceptName);
    _concept = Concept.fromJson(conceptName, description);
    onChange(_concept);
  }
}
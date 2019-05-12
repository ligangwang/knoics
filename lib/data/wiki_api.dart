import 'package:http/http.dart' as http;
import 'dart:convert';

class WikiAPI{
  static final String wikipediaApi = 'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exlimit=1&explaintext&titles=';

  static Future<String> getDescription(String concept) async{
    final response = await http.get(wikipediaApi + concept);
    if (response.statusCode == 200){
      return _parseExtract(response.body);
    }else{
      throw Exception("failed to retrieve description from wikipedia for concept: $concept.");
    }
  }

  static String _parseExtract(jsonString){
    final map = json.decode(jsonString);
    final pageMap = map['query']['pages'].values.toList()[0]; //first page selected
    return pageMap['extract'];
  }
}
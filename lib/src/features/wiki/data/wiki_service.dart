import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {
  static const String _baseUrl = 'https://fr.wikipedia.org/api/rest_v1/page/summary';

  // récupération du résumé avec le titre de l'article
  Future<Map<String, dynamic>> fetchSummary(String title) async{
    final url = Uri.parse('$_baseUrl/$title');
    final response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération de l\'article : ${response.statusCode}');
    }
  }
}
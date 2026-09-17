import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

enum MiciStatus {conseille, modere, aProscrire, inconnu}

class MiciAnalysis {
  final MiciStatus status;
  final String explanation;

  MiciAnalysis({required this.status, required this.explanation});
}

// interrogation du modèle ollama pour analyser la compatibilité d'un produit avec les MICI
class OllamaService {
  static String get _baseUrl => dotenv.env['OLLAMA_BASE_URL'] ?? 'http://localhost:11434';
  static String get _model => dotenv.env['OLLAMA_MODEL'] ?? 'qwen.5:1.5b-instruct';

  Future<MiciAnalysis> analyzeMici({
    required String ingredients,
    required List<String> additives,
}) async {
    final additivesText = additives.isEmpty ? 'aucun additif listé'
        : additives.map((a) => a.replaceFirst('en:', '')).join(', ');

    final prompt = '''
    Tu es un assistant médical qui répond UNIQUEMENT en français, sans aucun caractère d'une autre langue (pas de chinois, pas d'anglais).
    
    Tu aides des patients atteints de MICI (maladies inflammatoires chroniques de l'intestin, type Crohn ou RCH) à évaluer un produit alimentaire.
    
    Ingrédients : $ingredients
    Additifs : $additivesText
    
    Consignes strictes :
    - Réponds uniquement en français
    - N'invente aucun ingrédient ou additif qui n'est pas dans la liste ci-dessus
    - Reste factuel et concis, sans détails superflus
    
    Réponds STRICTEMENT dans ce format, sans rien ajouter avant ou après :
    STATUT: [CONSEILLÉ ou MODÉRÉ ou A_PROSCRIRE]
    EXPLICATION: [2-3 phrases courtes et vulgarisées, en français uniquement]
    ''';

    final response = await http.post(
      Uri.parse('$_baseUrl/api/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': _model,
        'prompt': prompt,
        'stream': false,
        'options': {
          'temperature': 0.2,
          'top_p': 0.8,
          'repeat_penalty': 1.1,
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur : ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final rawText = data['response'] as String? ?? '';

    return _parseResponse(rawText);
  }

  MiciAnalysis _parseResponse(String raw) {
    final statusMatch = RegExp(r'STATUT:\s*(\w+)').firstMatch(raw);
    final explanationMatch = RegExp(r'EXPLICATION:\s*(.*)', dotAll: true).firstMatch(raw);

    final statusStr = statusMatch?.group(1)?.trim().toUpperCase() ?? '';
    final explanation = explanationMatch?.group(1)?.trim() ?? raw.trim();

    MiciStatus status;
    switch (statusStr) {
      case 'CONSEILLÉ':
        status = MiciStatus.conseille;
        break;
      case 'MODÉRÉ':
        status = MiciStatus.modere;
        break;
      case 'A_PROSCRIRE':
        status = MiciStatus.aProscrire;
        break;
      default:
        status = MiciStatus.inconnu;
    }

    return MiciAnalysis(status: status, explanation: explanation);
  }
}
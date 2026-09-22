import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'mici_analysis_service.dart';

// api groq (cloud)
class GroqService implements MiciAnalysisService {
  static const String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';
  static String get _model => dotenv.env['GROQ_MODEL'] ?? 'openai/gpt-oss-20b';

  @override
  Future<MiciAnalysis> analyzeMici({
    required String ingredients,
    required List<String> additives,
  }) async {
    if (_apiKey.isEmpty) {
      throw Exception('clé API Groq manquante dans le .env');
    }

    final prompt = buildMiciPrompt(ingredients: ingredients, additives: additives);

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.2,
        'top_p': 0.8,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur Groq : ${response.statusCode} - ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final rawText = data['choices']?[0]?['message']?['content'] as String? ?? '';
    print('=== RAW GROQ RESPONSE ===');
    print(rawText);
    print('=== FIN RAW ===');
    return parseMiciResponse(rawText);
  }
}
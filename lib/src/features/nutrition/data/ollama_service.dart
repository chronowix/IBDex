import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'mici_analysis_service.dart';

class OllamaService implements MiciAnalysisService {
  static String get _baseUrl => dotenv.env['OLLAMA_BASE_URL'] ?? 'http://localhost:11434';
  static String get _model => dotenv.env['OLLAMA_MODEL'] ?? 'qwen2.5:1.5b-instruct';

  @override
  Future<MiciAnalysis> analyzeMici({
    required String ingredients,
    required List<String> additives,
  }) async {
    final prompt = buildMiciPrompt(ingredients: ingredients, additives: additives);

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
      throw Exception('Erreur Ollama : ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return parseMiciResponse(data['response'] as String? ?? '');
  }
}
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'mici_analysis_service.dart';
import 'ollama_service.dart';
import 'groq_service.dart';

MiciAnalysisService getMiciAnalysisService() {
  final provider = dotenv.env['AI_PROVIDER'] ?? 'ollama';

  switch (provider) {
    case 'groq':
      return GroqService();
    case 'ollama':
    default:
      return OllamaService();
  }
}
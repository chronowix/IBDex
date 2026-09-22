enum MiciStatus { conseille, modere, aProscrire, inconnu }

class MiciAnalysis {
  final MiciStatus status;
  final String explanation;

  MiciAnalysis({required this.status, required this.explanation});
}

abstract class MiciAnalysisService {
  Future<MiciAnalysis> analyzeMici({
    required String ingredients,
    required List<String> additives,
  });
}

MiciAnalysis parseMiciResponse(String raw) {
  final statusMatch = RegExp(r'STATUT:\s*(\w+)').firstMatch(raw);
  final explanationMatch = RegExp(r'EXPLICATION:\s*(.+)', dotAll: true).firstMatch(raw);

  final statusStr = statusMatch?.group(1)?.trim().toUpperCase() ?? '';
  final explanation = explanationMatch?.group(1)?.trim() ?? raw.trim();

  MiciStatus status;
  switch (statusStr) {
    case 'CONSEILLE':
      status = MiciStatus.conseille;
      break;
    case 'MODERE':
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

String buildMiciPrompt({
  required String ingredients,
  required List<String> additives,
}) {
  final additivesText = additives.isEmpty
      ? 'aucun additif listé'
      : additives.map((a) => a.replaceFirst('en:', '')).join(', ');

  return '''
Tu es un assistant médical qui répond UNIQUEMENT en français, sans aucun caractère d'une autre langue (pas de chinois, pas d'anglais).

Tu aides des patients atteints de MICI (maladies inflammatoires chroniques de l'intestin, type Crohn ou RCH) à évaluer un produit alimentaire.

Ingrédients : $ingredients
Additifs : $additivesText

Consignes strictes :
- Réponds uniquement en français
- Utilise UNIQUEMENT le terme "MICI" pour désigner la maladie. N'utilise JAMAIS "IBD" (terme anglais), "MICS", ni aucune autre variante ou abréviation.
- N'invente aucun ingrédient ou additif qui n'est pas dans la liste ci-dessus
- Reste factuel et concis, sans détails superflus

Réponds STRICTEMENT dans ce format, sans rien ajouter avant ou après :
STATUT: [CONSEILLE ou MODERE ou A_PROSCRIRE]
EXPLICATION: [2-3 phrases courtes et vulgarisées, en français uniquement, utilisant uniquement le terme MICI]

Important : le champ STATUT doit être écrit exactement comme ci-dessus, SANS accent (MODERE et non MODÉRÉ, CONSEILLE et non CONSEILLÉ).
''';
}
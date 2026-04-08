import 'package:flutter/material.dart';

// Page de conseil nutrition, cette page sera susceptible d'évoluer avec une API plus complète lorsque l'appli sera plus conséquente
class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  Widget _buildCategoryTile(String title, List<Widget> items){
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      children: items,
    );
  }

  Widget _buildFoodItem(String name, String status, String advice){
    return ListTile(
      title: Text(name),
      subtitle: Text(advice),
      trailing: Icon(
        status == 'Conseillé' ? Icons.check_circle : Icons.warning_rounded,
        color: status == 'Conseillé' ? Colors.green : status == 'À éviter' ? Colors.red : Colors.orange,
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildCategoryTile('Féculents/Légumineuses',[
            _buildFoodItem('Riz blanc', 'Conseillé', 'Parfait lors des poussées'),
            _buildFoodItem('Riz rond/à sushi', 'Conseillé', 'Parfait lors des poussées'),
            _buildFoodItem('Pâtes blanches', 'Conseillé', 'Très digeste'),
            _buildFoodItem('Semoule', 'Conseillé', 'Privilégier la semoule fine type couscous'),
            _buildFoodItem('Pommes de terres', 'Conseillé', 'En purée ou en vapeur'),
            _buildFoodItem('Pain blanc', 'Conseillé', 'Pauvre en fibres'),
            _buildFoodItem('Biscottes', 'Conseillé', 'Pauvre en fibres'),
            _buildFoodItem('Maïs', 'Conseillé', 'Privilégier le maïs raffiné type polenta fine'),
            _buildFoodItem('Tapioca', 'Conseillé', 'Remplace les farines contenant du gluten'),
            _buildFoodItem('Fécule de maïs (Maïzena)', 'Conseillé', 'Remplace les farines contenant du gluten'),

            _buildFoodItem('Boulgour', 'Modéré', 'à consommer en petites quantités'),
            _buildFoodItem('Quinoa', 'Modéré', 'Digestibilité variable'),
            _buildFoodItem('Blé', 'Modéré', 'Les formes complètes du blé sont à éviter'),
            _buildFoodItem('Avoine', 'Modéré', 'Privilégier du son d\'avoine ou des flocons bien cuits'),
            _buildFoodItem('Sarrasin', 'Modéré', 'Digestibilité variable'),
            _buildFoodItem('Pommes de terres rissolés/frites', 'Modéré', 'Peut provoquer des poussées si mangés en quantité importante!'),
            _buildFoodItem('Patate douce', 'Modéré', 'Contient des fibres mais bien tolérée'),
            _buildFoodItem('Épeautre', 'Modéré', 'Mal toléré lors des poussées'),
            _buildFoodItem('Soja', 'Modéré', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),


            _buildFoodItem('Pâtes complètes', 'À éviter', 'Les fibres dites "dures" peuvent irriter le microbiote'),
            _buildFoodItem('Orge', 'À éviter', 'Riche en fibres'),
            _buildFoodItem('Seigle', 'À éviter', 'Riche en fibres'),
            _buildFoodItem('Pain complet', 'À éviter', 'Irritation du microbiote si mangé en quantité quotidiennement'),
            _buildFoodItem('Lentilles', 'À éviter', 'Parfait lors des poussées'),
            _buildFoodItem('Pois chiches', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
            _buildFoodItem('Haricots blancs', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
            _buildFoodItem('Haricots rouges', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
            _buildFoodItem('Fèves', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
            _buildFoodItem('Flageolets', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
            _buildFoodItem('Pois cassés', 'À éviter', 'Fermentation: provoque des gaz/ballonnements et diarrhée'),
          ]),
          _buildCategoryTile('Fruits',[
            _buildFoodItem('Banane mûre', 'Conseillé', 'Incontournable'),
            _buildFoodItem('Compote pommes ou poires', 'Conseillé', 'Attention aux fibres insolubles'),
            _buildFoodItem('Pommes cuites', 'Conseillé', 'Attention aux fibres insolubles'),
            _buildFoodItem('Poires cuites', 'Conseillé', 'Attention aux fibres insolubles'),
            _buildFoodItem('Coing', 'Conseillé', 'Attention aux fibres'),
            _buildFoodItem('Pêche/Nectarine pelée', 'Conseillé', 'Attention aux fibres'),

            _buildFoodItem('Tous types de fruits rouges', 'Modéré', 'Mixés et sans graines si possible'),
            _buildFoodItem('Melon/Pastèque', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Papaye', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Mangue', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Avocat', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Kiwi', 'Modéré', 'Attention, peut irriter'),
            _buildFoodItem('Agrumes (orange, clémentine...)', 'Modéré', 'Attention à l\'acidité'),
            _buildFoodItem('Raisin', 'Modéré', 'A manger sans peau et sans pépins'),

            _buildFoodItem('Fruits crus avec peau', 'À éviter', 'Attention aux fibres'),
            _buildFoodItem('Fruits secs (pruneaux, abricots secs...)', 'À éviter', 'Attention aux fibres'),
            _buildFoodItem('Fruits oléagineux (noix, noisettes, amandes...)', 'À éviter', 'Attention aux fibres'),
            _buildFoodItem('Prune', 'À éviter', 'Très fibreux, limiter sa consommation'),
            _buildFoodItem('Abricot', 'À éviter', 'Très fibreux, limiter sa consommation'),
            _buildFoodItem('Cerises', 'À éviter', 'Très fibreux, limiter sa consommation'),
            _buildFoodItem('Ananas', 'À éviter', 'Très acide, limiter sa consommation'),
            _buildFoodItem('Fruit de la passion', 'À éviter', 'Très acide, limiter sa consommation'),
            _buildFoodItem('Citron (pur)', 'À éviter', 'Très acide, limiter sa consommation'),

          ]),
          _buildCategoryTile('Légumes',[
            _buildFoodItem('Carottes cuites', 'Conseillé', 'Incontournable'),
            _buildFoodItem('Haricots verts', 'Conseillé', 'Doit être bien cuit'),
            _buildFoodItem('Courgette', 'Conseillé', 'Doit être épluchée et épépinée'),
            _buildFoodItem('Épinards', 'Conseillé', 'Doivent être cuits'),
            _buildFoodItem('Poireaux', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Potiron/Courge', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Betterave', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Aubergine', 'Modéré', 'Attention aux fibres'),
            _buildFoodItem('Poireaux', 'Modéré', 'Attention aux fibres'),

          ]),
          _buildCategoryTile('Boissons',[
            _buildFoodItem('Eau plate', 'Conseillé', 'Une hydratation optimale pour un microbiote en forme'),
            _buildFoodItem('Thé vert', 'Modéré', 'Contient de la théine'),
            _buildFoodItem('Thé noir', 'Modéré', 'Contient plus de théine que le thé vert'),
            _buildFoodItem('Jus d\'orange', 'À éviter', 'Forte teneur en sucre'),
            _buildFoodItem('Sodas (Coca-Cola, Schweppes, 7Up...)', 'À éviter', 'Provoque ballonnements et gaz'),

          ]),
        ],
      ),
    );
  }
}

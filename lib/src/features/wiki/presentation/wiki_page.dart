import 'package:flutter/material.dart';
import 'wiki_category_page.dart';

/// Wiki sur les maladies (Crohn, RCH) et les traitements.
class WikiPage extends StatelessWidget {
  const WikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wiki IBDex')),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCategoryCard(
            context,
            'Maladies',
            Icons.biotech,
            Colors.blue,
            ['Maladie_de_Crohn', 'Rectocolite_hémorragique', 'Colite'],
          ),

          _buildCategoryCard(
            context,
            'Traitments',
            Icons.medication,
            Colors.green,
            ['Infliximab', 'Adalimumab', 'Corticostéroïde'],
          ),

          _buildCategoryCard(
            context,
            'Symptômes',
            Icons.warning_amber,
            Colors.orange,
            ['Douleur_abdominale', 'Fatigue_(physiologie)', 'Anémie'],
          ),

          _buildCategoryCard(
            context,
            'Examens',
            Icons.visibility,
            Colors.purple,
            ['Coloscopie', 'Échographie', 'Prise_de_sang'],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, List<String> titles){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WikiCategoryPage(
                categoryTitle: title,
                wikiTitles: titles,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

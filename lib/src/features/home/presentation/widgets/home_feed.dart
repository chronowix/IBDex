// Widget fil d'actualité de l'onglet Accueil
import 'package:flutter/material.dart';

class HomeFeed extends StatelessWidget{
  const HomeFeed({super.key});

  Widget _buildNewsCard(String title, String time, String imageUrl){
    return InkWell(
      onTap: () {
        // TODO: navigation vers les articles à faire
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover,),
            ListTile(title: Text(title),subtitle: Text('Publié $time - Par l\'équipe IBDex')),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context){
    // liste des nouveaux posts
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('A la Une', style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),

        //duplication des cartes pour tester le défilement
        _buildNewsCard('Nouvelles sur la maladie de Crohn', "il y a 2h", 'https://picsum.photos/600/300?random=1'),
        const SizedBox(height: 16),
        _buildNewsCard('5 conseils pour votre alimentation', "il y a 5h", 'https://picsum.photos/600/300?random=2'),
        const SizedBox(height: 16),
        _buildNewsCard('Le saviez-vous?', "Hier", 'https://picsum.photos/600/300?random=3'),
      ],
    );
  }
}
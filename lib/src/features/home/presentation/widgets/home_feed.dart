// Widget fil d'actualité de l'onglet Accueil
import 'package:flutter/material.dart';
import 'package:ibdex/src/shared/data/mock_data.dart';
import 'package:ibdex/src/features/articles/presentation/article_detail_page.dart';
import 'package:ibdex/src/features/advice/presentation/advice_detail_page.dart';

class HomeFeed extends StatelessWidget{
  const HomeFeed({super.key});

  Widget _buildNewsCard(BuildContext context, String title, String time, String imageUrl, Widget destinationPage){
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destinationPage),
        );
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
    // Utilisation des données centralisées MockData
    final articleTest = MockData.articles[0];
    final adviceTest = MockData.advices[0];
    
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('A la Une', style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),

        _buildNewsCard(context, articleTest.title, '2h', articleTest.imageUrl, ArticleDetailPage(article: articleTest)),
        const SizedBox(height: 16),
        _buildNewsCard(context, adviceTest.title, '5h', adviceTest.imageUrl, AdviceDetailPage(advice: adviceTest)),
      ],
    );
  }
}
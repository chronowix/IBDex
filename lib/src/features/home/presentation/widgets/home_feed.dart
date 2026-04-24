// Widget fil d'actualité de l'onglet Accueil
import 'package:flutter/material.dart';
import 'package:ibdex/src/shared/models/article.dart';
import 'package:ibdex/src/shared/models/advice.dart';
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
    // liste des nouveaux posts
    final articleTest = Article(id: '1', title: 'Actu Crohn', content: 'Découvrez les dernières avancées sur les traitements personnalisés à Rennes...', imageUrl: 'https://picsum.photos/600/300?random=1', publishedAt: DateTime.now(), category: 'Maladies');
    final adviceTest = Advice(id: '1', title: 'Conseil Nutrition', content: 'Si vous ressentez des poussées à force de manger la même chose ou un même aliment...', imageUrl: 'https://picsum.photos/600/300?random=2', publishedAt: DateTime.now(), category: 'Nutrition', myExperience: 'De mon côté, j\'ai dû limiter les sodas et le gluten car j\'ai remarqué que mes poussées se déclenchaient...');
    
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
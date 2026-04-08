import 'package:flutter/material.dart';
import 'package:ibdex/src/features/articles/presentation/article_detail_page.dart';
import '../../../shared/models/article.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  // mock des articles
  static final List<Article> _mockArticles = [
    Article(
      id: '1',
      title: "Nouvelles sur Crohn",
      content: "Un nouveau traitement a été breveté...",
      imageUrl: 'https://picsum.photos/400/200?random=11',
      publishedAt: DateTime.now(),
      category: 'Maladie',
    ),
    Article(
        id: '2',
        title: "Nouvelles sur RCH",
        content: "Un nouveau type de dépistage a été découvert...",
        imageUrl: 'https://picsum.photos/400/200?random=12',
        publishedAt: DateTime.now(),
        category: 'Maladie',
    ),
    Article(
        id: '3',
        title: "Les traitements à Rennes",
        content: "Où se soigner à Rennes...",
        imageUrl: 'https://picsum.photos/400/200?random=13',
        publishedAt: DateTime.now(),
        category: 'Soins',
    ),
  ];

  Widget _buildArticleItem(BuildContext context, Article article){
    return Card(
      child: ListTile(
        leading: Image.network(article.imageUrl, width: 80, fit: BoxFit.cover),
        title: Text(article.title),
        subtitle: Text(article.category),
        onTap: (){
          //TODO: ouvrir détail de l'article
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article: article))
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _mockArticles.length,
        itemBuilder: (context, index){
          final article = _mockArticles[index];
          return _buildArticleItem(context, article);
        },
      ),
    );
  }
}

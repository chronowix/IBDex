import 'package:flutter/material.dart';
import 'package:ibdex/src/features/articles/presentation/article_detail_page.dart';
import 'package:ibdex/src/shared/data/mock_data.dart';
import '../../../shared/models/article.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  Widget _buildArticleItem(BuildContext context, Article article){
    return Card(
      child: ListTile(
        leading: Image.network(article.imageUrl, width: 80, fit: BoxFit.cover),
        title: Text(article.title),
        subtitle: Text(article.category),
        onTap: (){
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
    final articles = MockData.articles;
    return Scaffold(
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index){
          final article = articles[index];
          return _buildArticleItem(context, article);
        },
      ),
    );
  }
}

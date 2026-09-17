import 'package:flutter/material.dart';
import '../../../shared/models/article.dart';

class ArticleDetailPage extends StatelessWidget{
  final Article article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail de l\'article'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // image
            Image.network(
              article.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ // catégorie
                  Text(
                    article.category.toUpperCase(),
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text( // titre
                  article.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text( // date
                    'Publié le ${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Divider(height: 40),
                  Text( // contenu
                  article.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
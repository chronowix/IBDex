import 'package:flutter/material.dart';
import 'package:ibdex/src/shared/utils/url_helper.dart';
import '../models/wiki_article.dart';

class WikiDetailPage extends StatelessWidget{
  final WikiArticle article;
  const WikiDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.thumbnailUrl != null)
              Container(
                color: Colors.grey.shade100, // Fond blanc cassé pour la lisibilité
                width: double.infinity,
                height: 250,
                child: Image.network(
                  article.thumbnailUrl!,
                  fit: BoxFit.contain, // Pour ne pas couper les schémas médicaux
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.desc != null)
                    Text(
                      article.desc!.toUpperCase(),
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 40),
                  const Text(
                    'Résumé de Wikipédia : ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.extract,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: (){
                        UrlHelper.launchURL(article.contentUrl);
                      },
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text('Voir sur Wikipédia'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
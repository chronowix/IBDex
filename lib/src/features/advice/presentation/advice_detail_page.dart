import 'package:flutter/material.dart';
import '../../../shared/models/advice.dart';

class AdviceDetailPage extends StatelessWidget{
  final Advice advice;
  const AdviceDetailPage({super.key, required this.advice});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail du conseil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // image
            Image.network(
              advice.imageUrl,
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
                    advice.category.toUpperCase(),
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text( // titre
                    advice.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text( // date
                    'Publié le ${advice.publishedAt.day}/${advice.publishedAt.month}/${advice.publishedAt.year}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Divider(height: 40),
                  Text( // contenu
                    advice.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Divider(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.comment, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Mon vécu',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          advice.myExperience,
                          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                        )
                      ],
                    ),
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
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A propos d\'IBDex')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Merci d\'utiliser IBDex!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ce projet est né afin de rendre l\'information médicale sur les MICI le plus simple et accessible à Rennes et en Bretagne...',
              textAlign: TextAlign.justify,
            ),
            // texte perso à ajouter
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '"Devenir une encyclopédie de sa propre maladie, c\'est parfois la clé pour mieux la vivre."',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Projet réalisé entre plusieurs prises de sang ♥')
          ],
        ),
      ),
    );
  }
}
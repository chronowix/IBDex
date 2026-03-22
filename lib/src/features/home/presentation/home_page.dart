import 'package:flutter/material.dart';

// La page d'accueil de l'application IBDEX.
// Présente une introduction à la vulgarisation des MICI.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implémenter le Scaffold avec un AppBar (titre "IBDEX")
    // et un corps présentant le but de l'application.

    return Scaffold(
      appBar: AppBar(
        title: const Text('IBDex'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu IBDex')),
            ListTile(title: const Text('Mon Profil')),
            ListTile(title: const Text('A Propos')),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello World!')
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© 2026 IBDEX - Tous droits réservés',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
        )
      ),
    );
  }
}

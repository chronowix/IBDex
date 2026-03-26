import 'package:flutter/material.dart';
import 'package:ibdex/src/features/home/presentation/widgets/home_feed.dart';

//Page d'accueil
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() =>
      _HomePageState(); //création de l'état
}

class _HomePageState extends State<HomePage>{
  int _selectedIndex = 0; // quel onglet est actif
  //liste des pages
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeFeed(),
    Center(child: Text('Articles')),
    Center(child: Text('Wiki')),
    Center(child: Text('Conseils')),
    Center(child: Text('Nutrition')),
    Center(child: Text('Carte')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IBDex',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      drawer: Drawer( //menu burger
        child: Column(
          children: [
            SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Ma Santé'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Support'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon Profil'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: (){},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('A Propos'),
              onTap: (){},
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('© 2026 IBDEX - Tous droits réservés', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
      body: _widgetOptions[_selectedIndex], //affichage de la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          onTap: (int index){
            setState(() {
              _selectedIndex = index; //maj de l'index
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Wiki'),
            BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Conseils'),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Nutrition'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Carte'),
          ],
      ),
    );
  }
}

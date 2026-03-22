import 'package:flutter/material.dart';

//Page d'accueil
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() =>
      _HomePageState(); //création de l'état
}

class _HomePageState extends State<HomePage>{
  int _selectedIndex = 0; // quel onglet est actif
  //liste des pages
  static const List<Widget> _widgetOptions = <Widget>[
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
        title: const Text('IBDex'),
      ),
      drawer: Drawer( //menu burger
        child: Column(
          children: [
            const DrawerHeader(child: Text('Menu IBDex')),
            ListTile(title: const Text('Mon Profil')),
            ListTile(title: const Text('Paramètres')),
            const Spacer(),
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
          currentIndex: _selectedIndex,
          onTap: (int index){
            setState(() {
              _selectedIndex = index; //maj de l'index
            });
          },
          items: const [
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

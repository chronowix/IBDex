import 'package:flutter/material.dart';
import '../features/home/presentation/home_page.dart';

/// Le point d'entrée principal des widgets de l'application.
/// Définit le thème global et la navigation racine.
class IbdexApp extends StatelessWidget {
  const IbdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Définir ici le MaterialApp, le thème global et la page d'accueil
    // Utiliser HomePage() comme 'home' du MaterialApp
    return MaterialApp(
      title: 'IBDEX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
    //return const Placeholder();
  }
}

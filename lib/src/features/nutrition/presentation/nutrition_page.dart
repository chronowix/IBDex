import 'package:flutter/material.dart';
import '../data/open_food_facts_service.dart';
import '../models/food_product.dart';
import 'barcode_scanner_screen.dart';

// Page dédiée à la recherche et à l'analyse nutritionnelle des aliments.
class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final _searchController = TextEditingController();
  final _foodService = OpenFoodFactsService();

  List<FoodProduct> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  /// Lance la recherche auprès de l'API Open Food Facts.
  Future<void> _onSearchSubmitted(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _products.clear();
      });
      return;
    }
    if (_isLoading){
      _isLoading = true;
      _errorMessage = null;
    }

    // chargement de la liste
    setState(() {
      _isLoading =true;
      _errorMessage = null;
    });

    try {
      final results = await _foodService.searchProducts(query);
      if (mounted) {
        setState(() {
          _products = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = ('Erreur lors de la recherche : $e');
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onScanPressed() async {
    final barcode = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );

    if (barcode == null || !mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final product = await _foodService.getProductByBarcode(barcode);
      if (!mounted) return;

      if (product == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Produit non trouvé pour ce code-barre';
        });
        return;
      }

      setState(() {
        _products = [product]; //affiche le produit comme résultat
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erreur lors de la récupération du produit: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un aliment, produit...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: _onScanPressed,
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _products.clear());
                      },
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),

          // Zone d'affichage dynamique (Chargement, Erreur, Liste vide ou Résultats)
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  // Construit la vue en fonction de l'état actuel (chargement, erreur ou résultats).
  Widget _buildBody() {
    if (_isLoading == true){
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Erreur : $_errorMessage', style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Text('Recherchez un aliment pour voir sa composition'),
      );
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductTile(product);
      },
    );
  }

  /// Construit une tuile d'affichage pour un produit alimentaire.
  Widget _buildProductTile(FoodProduct product) {
    // TODO: 1. Afficher l'image du produit (product.imageUrl) ou une icône générique
    return ListTile(
      leading: product.imageUrl != null ? Image.network(
        product.imageUrl!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, size: 30),
      ) : const Icon(Icons.fastfood, size: 30),

      title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${product.brands ?? "Marque non précisée"} • ${product.additives.length} additif(s)'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // détails analyse : TODO
      },
    );
  }
}

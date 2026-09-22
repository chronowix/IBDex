import 'package:flutter/material.dart';
import 'package:ibdex/src/features/nutrition/data/check_ai_service.dart';
import 'package:ibdex/src/features/nutrition/data/mici_analysis_service.dart';
import 'package:ibdex/src/features/nutrition/models/food_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final FoodProduct product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _analysisService = getMiciAnalysisService();

  MiciAnalysis? _analysis;
  bool _isAnalyzing = false;
  String? _analyzisError;

  @override
  void initState() {
    super.initState();
    _runAnalysis();
  }

  Future<void> _runAnalysis() async {
    setState(() {
      _isAnalyzing = true;
      _analyzisError = null;
    });

    try {
      final result = await _analysisService.analyzeMici(
          ingredients: widget.product.ingredients ?? 'Non précisés',
          additives: widget.product.additives,
      );
      if (mounted) {
        setState(() {
          _analysis = result;
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _analyzisError = 'Analyse indisponible : $e';
          _isAnalyzing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (product.imageUrl != null)
            Center(
              child: Image.network(
                product.imageUrl!,
                height: 150,
                errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, size: 80),
              ),
            ),
          const SizedBox(height: 16),

          Text(product.brands ?? 'Marque non précisée',
            style: const TextStyle(fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),

          _buildMiciBadge(),
          const SizedBox(height: 24),

          const Text('Ingrédients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(product.ingredients ?? 'Non précisés'),
          const SizedBox(height: 24),

          const Text('Additifs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          _buildAdditivesList(product.additives),
        ],
      ),
    );
  }

  Widget _buildMiciBadge() {
    if (_isAnalyzing) {
      return const Row(
        children: [
          SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          SizedBox(width: 12),
          Text('Analyse en cours...'),
        ],
      );
    }

    if (_analyzisError != null) {
      return Row(
        children: [
          Expanded(child: Text(_analyzisError!, style: const TextStyle(color: Colors.red))),
          TextButton(onPressed: _runAnalysis, child: const Text('Réessayer')),
        ],
      );
    }

    if (_analysis == null) return const SizedBox.shrink();

    final (color, label, icon) = switch (_analysis!.status) {
      MiciStatus.conseille => (Colors.green, 'Conseillé', Icons.check_circle),
      MiciStatus.modere => (Colors.orange, 'A limiter', Icons.warning),
      MiciStatus.aProscrire => (Colors.red, 'A proscrire', Icons.dangerous),
      MiciStatus.inconnu => (Colors.grey, 'Non déterminé', Icons.help),
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Text(_analysis!.explanation),
        ],
      ),
    );
  }

  Widget _buildAdditivesList(List<String> additives) {
    if (additives.isEmpty) {
      return const Text('Aucun additif listé');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: additives.map((tag) {
        final code = tag.replaceFirst('en', '').toUpperCase();
        return Chip(label: Text(code));
      }).toList(),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_product.dart';

/// Service permettant d'interroger l'API Open Food Facts.
class OpenFoodFactsService {
  static const String _baseUrl = 'https://fr.openfoodfacts.org/cgi/search.pl';
  static const String _productUrl = 'https://fr.openfoodfacts.org/api/v2/product';
  static const String _userAgent = 'IBDex - Android/iOS - Version 1.0 - contact@ibdex.com';

  // Recherche des produits alimentaires par mot-clé (nom d'aliment, marque...).
  Future<List<FoodProduct>> searchProducts(String query) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'search_terms': query,
      'search_simple': '1',
      'action': 'process',
      'json': '1',
      'page_size': '20',
      'fields' : 'product_name,product_name_fr,brands,ingredients_text,ingredients_text_fr,additives_tags,image_front_small_url',
    });

    final response = await http.get(
      uri,
      headers: {'User-Agent': _userAgent},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> productsJson = data['products'] ?? [];

      return productsJson
          .map((item) => FoodProduct.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erreur lors de la récupération des produits : ${response.statusCode}',);
    }
  }

  Future<FoodProduct?> getProductByBarcode(String barcode) async {
    final uri = Uri.parse('$_productUrl/$barcode.json').replace(queryParameters: {
      'fields': 'product_name,product_name_fr,brands,ingredients_text,ingredients_text_fr,additives_tags,image_front_small_url',
    });

    final response = await http.get(uri, headers: {'User-Agent': _userAgent});

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la récupération du produit : ${response}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] != 1) {
      return null;
    }

    return FoodProduct.fromJson(data['product'] as Map<String, dynamic>);
  }
}

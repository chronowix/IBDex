/// Modèle représentant un produit alimentaire issu de l'API Open Food Facts.
class FoodProduct {
  final String name;
  final String? brands;
  final String? ingredients;
  final List<String> additives;
  final String? imageUrl;

  FoodProduct({
    required this.name,
    this.brands,
    this.ingredients,
    this.additives = const [],
    this.imageUrl,
  });

  // Construit un objet FoodProduct à partir d'un Map JSON d'Open Food Facts.
  // Le produit a les variables suivantes: name, brands, ingredients, additives et imageURL
  factory FoodProduct.fromJson(Map<String, dynamic> json) {
    return FoodProduct(
        name: json['product_name_fr'] ?? json['product_name'] ?? 'Produit sans nom',
        brands: json['brands'] as String?,
        ingredients: (json['ingredients_text_fr'] ?? json['ingredients_text']) as String?,
        additives: (json['additives_tags'] as List<dynamic>?)
            ?.map((tag) => tag.toString())
            .toList() ?? const [],
        imageUrl: (json['image_front_small_url'] ?? json['image_url']) as String?,
    );
  }
}

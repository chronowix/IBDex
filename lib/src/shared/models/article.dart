// Modèle pour l'article
class Article {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime publishedAt;
  final String category;

  //constructeur
  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.publishedAt,
    required this.category,
  });
}
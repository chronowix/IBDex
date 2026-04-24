//Modèle pour les conseils

class Advice {
  final String id;
  final String title;
  final String category;
  final String content;
  final String imageUrl; // à voir pour mettre image d'illustration ou pas?
  final DateTime publishedAt;
  final String myExperience;

  Advice({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
    required this.myExperience,
  });
}
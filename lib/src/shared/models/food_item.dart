class FoodItem {
  final String name;
  final String status; //Conseillé, Modéré, A éviter
  final String advice; //Conseil perso

  FoodItem({
    required this.name,
    required this.status,
    required this.advice
  });
}